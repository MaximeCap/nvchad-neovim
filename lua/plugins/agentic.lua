local function current_session()
  return require("agentic.session_registry").sessions[vim.api.nvim_get_current_tabpage()]
end

--- Dernier prompt tel que saisi, pas le rendu formaté du buffer de chat.
local function last_user_prompt(session)
  local history = session and session.chat_history
  local messages = history and history.messages or {}

  for i = #messages, 1, -1 do
    if messages[i].type == "user" and messages[i].text ~= "" then
      return messages[i].text
    end
  end
end

local function fill_prompt(session, text)
  vim.api.nvim_buf_set_lines(session.widget.buf_nrs.input, 0, -1, false, vim.split(text, "\n"))
  session.widget:show { focus_prompt = true }
end

-- Le widget n'expose pas de soumission publique : on tolère la disparition de
-- _submit_input en laissant le prompt dans l'input plutôt qu'en cassant.
local function submit_prompt(session)
  vim.schedule(function()
    local ok = pcall(function()
      session.widget:_submit_input()
    end)

    if not ok then
      vim.notify("Agentic: soumission auto indisponible, prompt laissé dans l'input", vim.log.levels.WARN)
    end
  end)
end

local function with_last_prompt(fn)
  local session = current_session()
  local text = session and last_user_prompt(session)

  if not text then
    vim.notify("Agentic: aucun prompt à rejouer", vim.log.levels.WARN)
    return
  end

  fn(session, text)
end

local function edit_last_prompt()
  with_last_prompt(fill_prompt)
end

local function retry_last_prompt()
  with_last_prompt(function(session, text)
    fill_prompt(session, text)
    submit_prompt(session)
  end)
end

-- Rejoue le prompt sur un contexte vierge : l'échange raté ne pèse plus sur la
-- réponse. L'ancienne session reste listée par <leader>as.
local function retry_in_new_session()
  with_last_prompt(function(_, text)
    require("agentic").new_session { auto_add_to_context = false }

    local session = current_session()
    if not session then
      return
    end

    session:on_session_ready(function(ready)
      fill_prompt(ready, text)
      submit_prompt(ready)
    end)
  end)
end

return {
  "carlos-algms/agentic.nvim",

  --- @type agentic.PartialUserConfig
  opts = {
    -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp" | "kiro-acp" | "pi-acp"
    provider = "codex-acp", -- setting the name here is all you need to get started
  },

  keys = {
    -- Accès rapide, hors du groupe <leader>a
    {
      "<C-\\>",
      function()
        require("agentic").toggle()
      end,
      mode = { "n", "v", "i" },
      desc = "Toggle Agentic Chat",
    },
    {
      "<C-'>",
      function()
        require("agentic").add_selection_or_file_to_context()
      end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic Context",
    },
    {
      "<C-,>",
      function()
        require("agentic").new_session()
      end,
      mode = { "n", "v", "i" },
      desc = "New Agentic Session",
    },

    -- Groupe <leader>a : tout est découvrable d'un coup avec which-key
    {
      "<leader>aa",
      function()
        require("agentic").toggle()
      end,
      mode = { "n", "v", "i" },
      desc = "Toggle chat",
    },
    {
      "<leader>ac",
      function()
        require("agentic").add_selection_or_file_to_context()
      end,
      mode = { "n", "v" },
      desc = "Add file/selection to context",
    },
    {
      "<leader>af",
      function()
        require("agentic").add_files_to_context()
      end,
      desc = "Add files to context (picker)",
    },
    {
      "<leader>ad", -- ai Diagnostics
      function()
        require("agentic").add_current_line_diagnostics()
      end,
      desc = "Add current line diagnostic",
      mode = { "n" },
    },
    {
      "<leader>aD", -- ai all Diagnostics
      function()
        require("agentic").add_buffer_diagnostics()
      end,
      desc = "Add all buffer diagnostics",
      mode = { "n" },
    },
    {
      "<leader>an",
      function()
        require("agentic").new_session()
      end,
      mode = { "n", "v", "i" },
      desc = "New session",
    },
    {
      "<leader>aN",
      function()
        require("agentic").new_session { auto_add_to_context = false }
      end,
      mode = { "n", "v", "i" },
      desc = "New session (contexte vide)",
    },
    {
      "<leader>ae",
      edit_last_prompt,
      mode = { "n", "i" },
      desc = "Edit last prompt",
    },
    {
      "<leader>ar",
      retry_last_prompt,
      mode = { "n", "i" },
      desc = "Retry last prompt",
    },
    {
      "<leader>aR",
      retry_in_new_session,
      mode = { "n", "i" },
      desc = "Retry last prompt (session vierge)",
    },
    {
      "<leader>as", -- ai Sessions
      function()
        require("agentic").restore_session()
      end,
      desc = "Restore session",
      silent = true,
      mode = { "n", "v", "i" },
    },
    {
      "<leader>ap",
      function()
        require("agentic").switch_provider()
      end,
      desc = "Switch provider",
    },
    {
      "<leader>ax",
      function()
        require("agentic").stop_generation()
      end,
      mode = { "n", "i" },
      desc = "Stop generation",
    },
  },
}
