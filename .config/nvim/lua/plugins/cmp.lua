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
  {
    'giuxtaposition/blink-cmp-copilot',
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.8.2',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      signature = { enabled = true },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      -- fuzzy = { implementation = 'prefer_rust_with_warning' },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'luasnip', 'easy-dotnet' },

        providers = {
          ['easy-dotnet'] = {
            name = 'easy-dotnet',
            enabled = true,
            module = 'easy-dotnet.completion.blink',
            score_offset = 10000,
            async = true,
          },
          copilot = {
            name = 'copilot',
            enabled = true,
            module = 'blink-cmp-copilot',
            min_keyword_length = 2,
            score_offset = -100,
            async = true,
          },
          luasnip = {
            name = 'luasnip',
            enabled = true,
            module = 'blink.cmp.sources.luasnip',
            min_keyword_length = 2,
            fallbacks = { 'snippets' },
            score_offset = 85, -- the higher the number, the higher the priority
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
-- vim: ts=2 sts=2 sw=2 et
