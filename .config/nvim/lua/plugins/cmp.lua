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
  -- {
  --   'giuxtaposition/blink-cmp-copilot',
  -- },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      -- { 'giuxtaposition/blink-cmp-copilot' },
    },
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

      --
      -- fuzzy = { implementation = 'prefer_rust_with_warning' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
        kind_icons = {
          Copilot = '',
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'easy-dotnet' },
        per_filetype = {
          sql = { 'snippets', 'dadbod', 'buffer' },
        },

        providers = {
          ['easy-dotnet'] = {
            name = 'easy-dotnet',
            enabled = true,
            module = 'easy-dotnet.completion.blink',
            score_offset = 10000,
            async = true,
          },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
          -- copilot = {
          --   name = 'copilot',
          --   enabled = true,
          --   module = 'blink-cmp-copilot',
          --   score_offset = -100,
          --   async = true,
          --   transform_items = function(_, items)
          --     local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
          --     local kind_idx = #CompletionItemKind + 1
          --     CompletionItemKind[kind_idx] = 'Copilot'
          --     for _, item in ipairs(items) do
          --       item.kind = kind_idx
          --     end
          --     return items
          --   end,
          -- },
          -- luasnip = {
          --   name = 'luasnip',
          --   enabled = true,
          --   module = 'blink.cmp.sources.luasnip',
          --   min_keyword_length = 2,
          --   fallbacks = { 'snippets' },
          --   score_offset = 85, -- the higher the number, the higher the priority
          -- },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
-- vim: ts=2 sts=2 sw=2 et
