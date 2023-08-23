local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "silentz.lsp.language_servers"
require("silentz.lsp.handlers").setup()
require "silentz.lsp.null-ls"
require "silentz.lsp.docstrings"
