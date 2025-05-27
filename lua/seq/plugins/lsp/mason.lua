return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'

    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    mason_lspconfig.setup {
      ensure_installed = {
        'html',
        'cssls',
        'tailwindcss',
        'lua_ls',
        'emmet_ls',
        -- no agregues 'tsserver' si estás usando `typescript-tools.nvim`
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'prettier',
        'stylua',
        'isort',
        'black',
        'pylint',
        'eslint_d',
      },
    }

    -- ✅ Configura automáticamente los servidores usando lspconfig
    local ok, lspconfig = pcall(require, 'lspconfig')
    if not ok then
      return
    end

    local ok2, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if not ok2 then
      return
    end

    if mason_lspconfig.setup_handlers then
      mason_lspconfig.setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = cmp_nvim_lsp.default_capabilities(),
          }
        end,
      }
    end
  end,
}
