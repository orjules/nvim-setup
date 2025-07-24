-- Option 1: nvim-autopairs (most popular, feature-rich)
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local autopairs = require('nvim-autopairs')
    
    autopairs.setup({
      check_ts = true,                        -- Use treesitter
      ts_config = {
        lua = {'string', 'source'},
        javascript = {'string', 'template_string'},
        java = false,                         -- Don't add pairs in java
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      disable_in_macro = true,                -- Disable when recording macros
      disable_in_visualblock = false,
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,               -- Add bracket pairs after quote
      enable_check_bracket_line = true,       -- Check bracket in same line
      enable_bracket_in_quote = true,
      enable_abbr = false,                    -- Trigger abbreviation
      break_undo = true,                      -- Switch for basic rule break undo sequence
      check_comma = true,
      map_cr = true,                          -- Map <CR> key
      map_bs = true,                          -- Map backspace key
      map_c_h = false,                        -- Map <C-h> key to delete pair
      map_c_w = false,                        -- Map <C-w> to delete pair if possible
    })
    
    -- Integration with cmp
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
  dependencies = { 'hrsh7th/nvim-cmp' },
}
