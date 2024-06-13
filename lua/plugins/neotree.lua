return {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = true,
    opts = {
        filesystem = { filtered_items = {
            visible = false,
            show_hidden_count = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_by_pattern = { '*.spec.ts' },
            hide_by_name = { 'package-lock.json' },
            never_show = {},
        } },
        window = { position = 'float' },
        popup_border_style = 'rounded',
    },
}
