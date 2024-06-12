return {
  -- usage: lua MiniTrailspace.trim()
  {
    "echasnovski/mini.trailspace",
    version = "*",
    config = function()
      require("mini.trailspace").setup()
    end,
  },
}
