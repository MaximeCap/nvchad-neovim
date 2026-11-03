-- Sélecteur de thème : API natives Neovim + Snacks picker.
-- Aperçu en direct au déplacement du curseur, restauration si on annule,
-- choix persisté dans stdpath("state")/colorscheme.
local M = {}

M.default = "kanagawa"
local state_file = vim.fn.stdpath "state" .. "/colorscheme"

local function read_state()
  local f = io.open(state_file, "r")
  if not f then
    return nil
  end
  local name = f:read "*l"
  f:close()
  return name ~= "" and name or nil
end

local function write_state(name)
  local f = io.open(state_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

---@param name string
---@return boolean ok
function M.apply(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify(("Colorscheme '%s' introuvable : %s"):format(name, err), vim.log.levels.WARN)
  end
  return ok
end

--- Applique le thème sauvegardé (ou le défaut) au démarrage.
function M.load()
  local name = read_state() or M.default
  if not M.apply(name) and name ~= M.default then
    M.apply(M.default)
  end
end

--- Liste les colorschemes installés (hors thèmes fournis avec Neovim),
--- y compris ceux des plugins lazy.nvim pas encore chargés.
---@return {text:string, file:string}[]
function M.list()
  local rtp = vim.o.runtimepath
  if package.loaded.lazy then
    rtp = rtp .. "," .. table.concat(require("lazy.core.util").get_unloaded_rtp "", ",")
  end
  local runtime = vim.fs.normalize(vim.env.VIMRUNTIME)
  local seen, items = {}, {}
  for _, file in ipairs(vim.fn.globpath(rtp, "colors/*.{vim,lua}", false, true)) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if not seen[name] and not vim.startswith(vim.fs.normalize(file), runtime) then
      seen[name] = true
      items[#items + 1] = { text = name, file = file }
    end
  end
  table.sort(items, function(a, b)
    return a.text < b.text
  end)
  return items
end

function M.pick()
  local original = vim.g.colors_name or M.default
  local confirmed = false
  local items = M.list()

  -- Place le curseur sur le thème actif à l'ouverture.
  for i, item in ipairs(items) do
    if item.text == original then
      table.insert(items, 1, table.remove(items, i))
      break
    end
  end

  require("snacks").picker.pick {
    title = "Thèmes",
    items = items,
    format = "text",
    preview = "none",
    layout = { preset = "select" },
    on_change = function(_, item)
      if item and item.text ~= vim.g.colors_name then
        M.apply(item.text)
      end
    end,
    confirm = function(picker, item)
      confirmed = true
      picker:close()
      if item then
        M.apply(item.text)
        write_state(item.text)
        vim.notify("Thème : " .. item.text .. " (sauvegardé)")
      end
    end,
    on_close = function()
      if not confirmed and vim.g.colors_name ~= original then
        vim.schedule(function()
          M.apply(original)
        end)
      end
    end,
  }
end

vim.api.nvim_create_user_command("Theme", function(opts)
  if opts.args == "" then
    return M.pick()
  end
  if M.apply(opts.args) then
    write_state(opts.args)
  end
end, {
  nargs = "?",
  desc = "Choisir un thème (persistant)",
  complete = function(lead)
    return vim.tbl_filter(function(n)
      return vim.startswith(n, lead)
    end, vim.tbl_map(function(i)
      return i.text
    end, M.list()))
  end,
})

return M
