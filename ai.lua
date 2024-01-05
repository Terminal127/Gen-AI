local curl = require('plenary.curl')

local M = {}

local win_id

function M.askGemini(prompt, callback)
  curl.post('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=' .. M.opts.api_key, {
    raw = { '-H', 'Content-type: application/json' },
    body = vim.fn.json_encode({
      contents = {
        {
          parts = {
            text = prompt,
          },
        },
      },
    }),
    callback = function(res)
      vim.schedule(function()
        local result
        if res.status ~= 200 then
          result = 'Error: ' .. tostring(res.status) .. '\n\n' .. res.body
        else
          local data = vim.fn.json_decode(res.body)
          result = data.candidates[1].content.parts[1].text
        end
        callback(result)
      end)
    end,
  })
end

function M.wrapText(content, max_width)
  local wrapped_lines = {}
  for _, line in ipairs(content) do
    local current_line = ''
    for word in line:gmatch('%S+') do
      if #current_line + #word > max_width then
        table.insert(wrapped_lines, current_line)
        current_line = word
      else
        current_line = current_line == '' and word or current_line .. ' ' .. word
      end
    end
    table.insert(wrapped_lines, current_line)
  end
  return wrapped_lines
end

function M.createPopup(content)
  M.close()

  local max_width = 60 -- Adjust this value as needed
  content = M.wrapText(content, max_width)

  local bufnr = vim.api.nvim_create_buf(false, true)
  win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = 'editor',
    width = max_width + 2, -- Adjust this value as needed
    height = #content + 20,
    style = 'minimal',
    border = 'single',
    row = vim.fn.line('.') + 1,
    col = vim.fn.wincol() + 1,
  })

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, content)

  return function(new_content)
    new_content = M.wrapText(new_content, max_width)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, new_content)
  end
end

function M.close()
  if win_id and vim.api.nvim_win_is_valid(win_id) then
    pcall(vim.api.nvim_win_close, win_id, true)
    win_id = nil
  end
end

function M.handle(prompt)
  local update = M.createPopup({'Asking Gemini...'})
  M.askGemini(prompt, function(result)
    update({result})
  end)
end

function M.setup(opts)
  M.opts = vim.tbl_extend('force', {
    api_key = '',  -- Replace with your actual API key
    locale = 'en',
    alternate_locale = 'zh',
  }, opts)

  assert(M.opts.api_key ~= nil and M.opts.api_key ~= '', 'api_key is required')
end

return M

