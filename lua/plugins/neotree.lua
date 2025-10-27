return {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = { 'saifulapm/neotree-file-nesting-config' },
    enabled = true,
    opts = {
        hide_root_node = true,
        retain_hidden_root_indent = true,
        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = '',
                expander_expanded = '',
            },
        },
        filesystem = {
            filtered_items = {
                visible = false,
                show_hidden_count = false,
                hide_dotfiles = true,
                hide_gitignored = true,
                hide_by_pattern = { '*.spec.ts' },
                hide_by_name = { 'package-lock.json' },
                never_show = {},
            },
        },
        window = { position = 'float' },
        popup_border_style = 'rounded',
    },

    config = function(_, opts)
        -- Adding rules from plugin
        opts.nesting_rules = require('neotree-file-nesting-config').nesting_rules
        require('neo-tree').setup(opts)
    end,
}
