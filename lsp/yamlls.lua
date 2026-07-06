-- yamlls (yaml-language-server).
-- On désactive le schemaStore interne pour laisser SchemaStore.nvim fournir le
-- catalogue complet (sinon doublons / conflits d'association).
return {
  settings = {
    yaml = {
      schemaStore = {
        -- Important : couper le store intégré, c'est SchemaStore.nvim qui gère.
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
      validate = true,
    },
  },
}
