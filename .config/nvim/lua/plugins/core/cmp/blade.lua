return {
  {
    'ricardoramirezr/blade-nav.nvim',
    dependencies = {
      'saghen/blink.cmp',
    },
    ft = { 'blade', 'php' },
    opts = {
      close_tag_on_complete = true, -- default: true
    },
  },
}