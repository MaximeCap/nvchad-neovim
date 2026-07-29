-- jsonls (vscode-json-language-server).
-- Le serveur ne connaît aucun schéma tout seul : on lui passe le catalogue
-- schemastore.org via SchemaStore.nvim, plus la validation activée.
return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}
