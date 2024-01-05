-- this is the part for the plugin
require("ai").setup({ api_key = 'YOUR_API_KEY' }) -- Replace with your API key
vim.cmd("command! -range -nargs=? Gemini lua require('ai').handle(<q-args>)")
--
