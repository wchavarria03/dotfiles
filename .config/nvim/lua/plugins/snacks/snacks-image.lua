return {
  -- Image pasting support
  {
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        use_absolute_path = true,
      },
    },
  },
  -- Snacks image picker and utilities
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            filter = function(file)
              local ext = vim.fn.fnamemodify(file, ':e'):lower()
              local image_exts = { 'png', 'jpg', 'jpeg', 'gif', 'bmp', 'svg', 'webp', 'ico', 'tiff', 'tif' }
              for _, img_ext in ipairs(image_exts) do
                if ext == img_ext then
                  return true
                end
              end
              return false
            end
          },
        },
      },
    },
    keys = {
      { "<leader>fi", function()
        require("snacks").picker.files({
          filter = function(file)
            local ext = vim.fn.fnamemodify(file, ':e'):lower()
            local image_exts = { 'png', 'jpg', 'jpeg', 'gif', 'bmp', 'svg', 'webp', 'ico', 'tiff', 'tif' }
            for _, img_ext in ipairs(image_exts) do
              if ext == img_ext then
                return true
              end
            end
            return false
          end
        })
      end, desc = "Find Images" },
      { "<leader>ip", function()
        vim.cmd("ImgClipPaste")
      end, desc = "Paste Image" },
      { "<leader>ic", function()
        vim.cmd("ImgClipPaste")
      end, desc = "Image from Clipboard" },
    },
  },
} 