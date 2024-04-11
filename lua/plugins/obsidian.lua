return {
  'epwalsh/obsidian.nvim',
  config = function()
    require('obsidian').setup {
      dir = 'D:/Notes',
      new_notes_location = 'notes_subdir',
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      mappings = {
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = {
            noremap = false,
            expr = true,
            buffer = true,
          },
        },
      },
      note_id_func = function(title)
        local suffix = ''
        if title ~= nil then
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
          return suffix
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
            return tostring(os.time()) .. '-' .. suffix
          end
        end
      end,
      image_name_func = function()
        return string.format('%s-', os.time())
      end,
      note_frontmatter_func = function() end,
    }
  end,
}
