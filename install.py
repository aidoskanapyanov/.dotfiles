#!/usr/bin/env python3
import os
import shutil
import subprocess
import sys
from pathlib import Path

# Added curl and libfuse2 for Neovim setup requirements
PACKAGES = [
    "zsh", "zoxide", "tmux", "golang", "nethogs", "miller",
    "git-delta", "libtree-sitter-dev", "tree-sitter-cli", "urlview",
    "stow", "fd-find", "git", "curl", "libfuse2", "tar", "bat"
]

NVIM_VERSION = "v0.12.0"
NVIM_DOWNLOAD_URL = f"https://github.com/neovim/neovim/releases/download/{NVIM_VERSION}/nvim-linux-arm64.tar.gz"
NVIM_INSTALL_DIR = Path(f"/opt/nvim-{NVIM_VERSION}")
NVIM_BIN_LINK = Path("/usr/local/bin/nvim")

TS_VERSION = "v0.25.1"
TS_DOWNLOAD_URL = f"https://github.com/tree-sitter/tree-sitter/releases/download/{TS_VERSION}/tree-sitter-linux-arm64.gz"
TS_BIN_LINK = Path("/usr/local/bin/tree-sitter")

def install_latest_treesitter_cli() -> None:
    """Downloads and extracts the latest precompiled Tree-Sitter CLI binary to system paths."""
    print(f"--> Downloading Tree-Sitter CLI {TS_VERSION} for Linux ARM64...", flush=True)
    cmd_prefix = get_sudo_prefix()
    import tempfile

    with tempfile.TemporaryDirectory() as tmpdir:
        gz_file = Path(tmpdir) / "tree-sitter.gz"
        bin_file = Path(tmpdir) / "tree-sitter"

        try:
            # Download the gzip asset bundle
            subprocess.run(["curl", "-fL", TS_DOWNLOAD_URL, "-o", str(gz_file)], check=True)

            # Uncompress the standalone executable binary
            with open(bin_file, "wb") as f_out:
                subprocess.run(["gunzip", "-c", str(gz_file)], stdout=f_out, check=True)

            # Mark binary file as executable safely
            bin_file.chmod(0o755)

            # Force relocate framework target to system paths safely using sudo hooks
            print(f"   Deploying modern tree-sitter engine framework to {TS_BIN_LINK}", flush=True)
            subprocess.run(cmd_prefix + ["rm", "-f", str(TS_BIN_LINK)], check=True)
            subprocess.run(cmd_prefix + ["mv", str(bin_file), str(TS_BIN_LINK)], check=True)
            subprocess.run(cmd_prefix + ["chown", "root:root", str(TS_BIN_LINK)], check=True)

            # Verify extraction pipeline returns true status loops
            result = subprocess.run([str(TS_BIN_LINK), "--version"], capture_output=True, text=True)
            print(f"--> Tree-Sitter setup ready: {result.stdout.strip()}\n", flush=True)

        except subprocess.CalledProcessError as e:
            print(f"Error: Failed to install modern Tree-Sitter engine framework: {e}", file=sys.stderr)
            sys.exit(1)

def get_sudo_prefix() -> list[str]:
    """Helper to return sudo prefix if the user is running as non-root."""
    return [] if os.getuid() == 0 else ["sudo"]

def install_system_packages() -> None:
    """Updates apt cache and installs the required system utilities."""
    print("--> Updating apt package index...", flush=True)
    cmd_prefix = get_sudo_prefix()

    try:
        subprocess.run(cmd_prefix + ["apt-get", "update", "-y"], check=True)
        print(f"--> Installing packages: {', '.join(PACKAGES)}...", flush=True)
        subprocess.run(
            cmd_prefix + ["apt-get", "install", "-y", "--no-install-recommends"] + PACKAGES,
            check=True
        )
        print("--> System packages installed successfully.\n", flush=True)
    except subprocess.CalledProcessError as e:
        print(f"Error during package installation: {e}", file=sys.stderr)
        sys.exit(1)

def install_latest_fzf() -> None:
    """Clones fzf from git and executes the installer script according to official guidelines."""
    print("--> Installing latest fzf from GitHub source...", flush=True)

    # We will install fzf into /opt/fzf for a clean global path, or fall back to home
    fzf_dir = Path("/opt/fzf")
    cmd_prefix = get_sudo_prefix()

    try:
        # Create destination directory using sudo privileges if required
        if not fzf_dir.exists():
            subprocess.run(cmd_prefix + ["mkdir", "-p", str(fzf_dir)], check=True)
            subprocess.run(cmd_prefix + ["chown", f"{os.getuid()}:{os.getgid()}", str(fzf_dir)], check=True)

        # Clone repository or pull latest if directory is already present
        if not (fzf_dir / ".git").exists():
            subprocess.run(["git", "clone", "--depth", "1", "https://github.com/junegunn/fzf.git", str(fzf_dir)], check=True)
        else:
            subprocess.run(["git", "-C", str(fzf_dir), "pull"], check=True)

        # Execute installer with --bin to silently fetch the latest binary without altering shell profiles
        print("--> Running fzf installer script...", flush=True)
        subprocess.run([str(fzf_dir / "install"), "--bin"], check=True)

        # Symlink binary to a standard global system path
        fzf_bin_src = fzf_dir / "bin" / "fzf"
        fzf_bin_dst = Path("/usr/local/bin/fzf")

        if fzf_bin_src.exists():
            print(f"--> Creating global symlink for fzf at {fzf_bin_dst}...", flush=True)
            if fzf_bin_dst.exists() or fzf_bin_dst.is_symlink():
                subprocess.run(cmd_prefix + ["rm", "-f", str(fzf_bin_dst)], check=True)
            subprocess.run(cmd_prefix + ["ln", "-s", str(fzf_bin_src), str(fzf_bin_dst)], check=True)

        print("--> Latest fzf installed successfully from source.\n", flush=True)

    except subprocess.CalledProcessError as e:
        print(f"Error during fzf installation from source: {e}", file=sys.stderr)
        sys.exit(1)


def install_neovim() -> None:
    """Downloads and extracts the precompiled Neovim binary to system paths."""
    print(f"--> Checking Neovim installation target...", flush=True)
    cmd_prefix = get_sudo_prefix()

    # Avoid duplicate downloads if version folder exists
    if NVIM_INSTALL_DIR.exists() and NVIM_BIN_LINK.is_symlink():
        print(f"   Neovim {NVIM_VERSION} is already available. Skipping download...", flush=True)
        return

    print(f"--> Downloading Neovim {NVIM_VERSION} binary target...", flush=True)
    import tempfile

    with tempfile.TemporaryDirectory() as tmpdir:
        tar_file = Path(tmpdir) / "nvim.tar.gz"

        try:
            # Download file archive via built-in curl utility
            subprocess.run(["curl", "-L", NVIM_DOWNLOAD_URL, "-o", str(tar_file)], check=True)

            # Form directories with proper administrative scope privileges
            subprocess.run(cmd_prefix + ["mkdir", "-p", str(NVIM_INSTALL_DIR)], check=True)

            print(f"   Extracting components into system directory: {NVIM_INSTALL_DIR}", flush=True)
            # --strip-components=1 drops the wrapper nvim-linux-x86_64 directory inside the archive
            subprocess.run(
                cmd_prefix + ["tar", "-xzf", str(tar_file), "-C", str(NVIM_INSTALL_DIR), "--strip-components=1"],
                check=True
            )

            print(f"   Creating global environment symlink framework at {NVIM_BIN_LINK}", flush=True)
            subprocess.run(cmd_prefix + ["rm", "-f", str(NVIM_BIN_LINK)], check=True)
            subprocess.run(cmd_prefix + ["ln", "-s", str(NVIM_INSTALL_DIR / "bin" / "nvim"), str(NVIM_BIN_LINK)], check=True)

            # Verify executable availability
            result = subprocess.run([str(NVIM_BIN_LINK), "--version"], capture_output=True, text=True)
            first_line = result.stdout.splitlines()[0] if result.stdout else "Unknown version"
            print(f"--> Neovim setup ready: {first_line}\n", flush=True)

        except subprocess.CalledProcessError as e:
            print(f"Warning: Failed to setup Neovim ecosystem framework: {e}", file=sys.stderr)

def install_oh_my_zsh() -> None:
    """Installs Oh My Zsh non-interactively without breaking script execution."""
    omz_dir = Path.home() / ".oh-my-zsh"
    if omz_dir.exists():
        print("--> Oh My Zsh is already installed. Skipping...", flush=True)
        return

    print("--> Installing Oh My Zsh...", flush=True)

    custom_env = os.environ.copy()
    custom_env.update({"CHSH": "no", "RUNZSH": "no", "KEEP_ZSHRC": "yes"})

    try:
        cmd = 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
        subprocess.run(cmd, shell=True, env=custom_env, check=True)
        print("--> Oh My Zsh installed successfully.\n", flush=True)
    except subprocess.CalledProcessError as e:
        print(f"Warning: Oh My Zsh installation failed: {e}", file=sys.stderr)

def install_zsh_plugins() -> None:
    """Clones specified community plugins into the Oh My Zsh custom plugins directory."""
    plugins_base_dir = Path.home() / ".oh-my-zsh" / "custom" / "plugins"

    plugins = {
        "zsh-autosuggestions": "https://github.com/zsh-users/zsh-autosuggestions",
        "zsh-syntax-highlighting": "https://github.com/zsh-users/zsh-syntax-highlighting"
    }

    print("--> Installing external Zsh plugins...", flush=True)
    for name, url in plugins.items():
        target_dir = plugins_base_dir / name
        if target_dir.exists():
            print(f"   Plugin '{name}' already exists. Skipping...", flush=True)
            continue

        print(f"   Cloning: {name}...", flush=True)
        try:
            subprocess.run(["git", "clone", "--depth=1", url, str(target_dir)], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Warning: Failed to clone plugin '{name}': {e}", file=sys.stderr)
    print("--> Plugins installation complete.\n", flush=True)

def install_zsh_themes() -> None:
    """Clones the Powerlevel10k theme into the Oh My Zsh custom themes directory."""
    themes_base_dir = Path.home() / ".oh-my-zsh" / "custom" / "themes"
    p10k_dir = themes_base_dir / "powerlevel10k"

    print("--> Installing Powerlevel10k theme...", flush=True)
    if p10k_dir.exists():
        print("   Powerlevel10k already exists. Skipping...", flush=True)
        return

    try:
        subprocess.run([
            "git", "clone", "--depth=1",
            "https://github.com/romkatv/powerlevel10k.git",
            str(p10k_dir)
        ], check=True)
        print("--> Powerlevel10k theme installed successfully.\n", flush=True)
    except subprocess.CalledProcessError as e:
        print(f"Warning: Failed to clone Powerlevel10k: {e}", file=sys.stderr)

def delete_conflicting_targets(dotfiles_dir: Path, packages: list[str]) -> None:
    """Finds items inside each dotfile package and deletes their counterparts in $HOME."""
    home = Path.home()
    print("--> Scanning and deleting existing home directory conflicts...", flush=True)

    for pkg in packages:
        pkg_dir = dotfiles_dir / pkg
        for item in pkg_dir.iterdir():
            target_path = home / item.name

            if target_path.exists() or target_path.is_symlink():
                print(f"   Deleting existing conflict: {target_path}", flush=True)
                try:
                    if target_path.is_dir() and not target_path.is_symlink():
                        shutil.rmtree(target_path)
                    else:
                        target_path.unlink()
                except Exception as e:
                    print(f"   Warning: Could not delete {target_path}: {e}", file=sys.stderr)

def stow_dotfiles(dotfiles_dir: Path) -> None:
    """Discovers top-level directories and stows them one by one into the home directory."""
    stow_packages = [
        entry.name for entry in os.scandir(dotfiles_dir)
        if entry.is_dir() and not entry.name.startswith('.')
    ]

    if not stow_packages:
        print("Warning: No subdirectories found to stow.", file=sys.stderr)
        return

    delete_conflicting_targets(dotfiles_dir, stow_packages)

    print(f"--> Deploying dotfiles via GNU Stow...", flush=True)
    for package in stow_packages:
        print(f"   Stowing: {package}", flush=True)
        try:
            subprocess.run(
                ["stow", "-R", "-d", str(dotfiles_dir), "-t", str(Path.home()), package],
                check=True
            )
        except subprocess.CalledProcessError as e:
            print(f"Error stowing package '{package}': {e}", file=sys.stderr)


def install_rust() -> None:
    """Installs Rust toolchain via rustup, including cargo and rust-analyzer."""
    cargo_home = Path(os.environ.get("CARGO_HOME", Path.home() / ".cargo"))
    rustup_bin = cargo_home / "bin" / "rustup"
    cargo_bin = cargo_home / "bin" / "cargo"

    if rustup_bin.exists() and cargo_bin.exists():
        print("--> Rust toolchain already installed. Ensuring rust-analyzer component...", flush=True)
    else:
        print("--> Installing Rust toolchain via rustup...", flush=True)
        try:
            cmd = (
                "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs "
                "| sh -s -- -y --no-modify-path --default-toolchain stable"
            )
            subprocess.run(cmd, shell=True, check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error: Failed to install rustup: {e}", file=sys.stderr)
            sys.exit(1)

    # Make cargo/rustc/rust-analyzer available on PATH for the rest of this script
    os.environ["PATH"] = f"{cargo_home / 'bin'}{os.pathsep}{os.environ['PATH']}"

    try:
        subprocess.run([str(rustup_bin), "component", "add", "rust-analyzer"], check=True)

        for tool in ("rustc", "cargo", "rust-analyzer"):
            result = subprocess.run(
                [str(cargo_home / "bin" / tool), "--version"],
                capture_output=True, text=True, check=True
            )
            print(f"   {tool}: {result.stdout.strip()}", flush=True)

        print("--> Rust toolchain ready.\n", flush=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: Failed to configure Rust components: {e}", file=sys.stderr)
        sys.exit(1)

def main() -> None:
    # 1. Install system utilities (includes curl, libfuse2, tar)
    install_system_packages()

    # 1.2 install fzf separately
    install_latest_fzf()

    # 1.2 install fzf separately
    install_rust()

    # 2.0
    install_latest_treesitter_cli()

    # 2. Build custom binary infrastructure for Neovim v0.12
    install_neovim()

    # 3. Force deploy dotfiles first (your custom .zshrc and .p10k.zsh)
    dotfiles_dir_path = Path(__file__).parent.resolve()
    stow_dotfiles(dotfiles_dir_path)

    # 4. Setup Oh My Zsh base framework
    install_oh_my_zsh()

    # 5. Install plugins and themes
    install_zsh_plugins()
    install_zsh_themes()

    print("\n--> Setup complete!", flush=True)

if __name__ == "__main__":
    main()
