return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "lewis6991/async.nvim", -- Kept your fix here
    },
    -- This overrides and completely replaces LazyVim's broken config function
    config = function()
      require("refactoring").setup({})

      -- Safely check if telescope exists before attempting to load it
      local ok, telescope = pcall(require, "telescope")
      if ok then
        -- pcall stops the error from crashing Neovim if the extension fails
        pcall(telescope.load_extension, "refactoring")
      end
    end,
  },
}
