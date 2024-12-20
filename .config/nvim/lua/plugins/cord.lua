return {
  'vyfor/cord.nvim',
  build = './build || .\\build',
  event = 'VeryLazy',
  opts = {
    buttons = {
      {
        label = 'View Repository', -- Text displayed on the button
        url = 'git',             -- URL where the button leads to ('git' = automatically fetch Git repository URL)
      },
      {
        label = 'View Plugin',
        url = 'https://github.com/vyfor/cord.nvim',
      }
    },
  },
  config = function(_, opts)
    require('cord').setup { opts }
  end
}
