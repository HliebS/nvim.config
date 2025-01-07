return {
  "echasnovski/mini.statusline",
  version = false,
  dependencies = {
    { 
      "echasnovski/mini.icons",
      version = false,
      config = function()
        require("mini.icons").setup()
      end,
    },
    { 
      "echasnovski/mini-git",
      version = false,
      config = function()
        require("mini.git").setup()
      end,
    },
    {
      "echasnovski/mini.diff",
      version = false,
      config = function()
        require("mini.diff").setup()
      end,
    },
  },
  config = function()
    require("mini.statusline").setup()
  end,
}
