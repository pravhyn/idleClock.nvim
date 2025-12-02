local startTimer = require("idleClock.startTimer")
local async = require("plenary.async")

local M = {}
M.close = nil
M.created = false
function M.createBuffer()
        local buf = vim.api.nvim_create_buf(false, true) -- [listed=false, scratch=true]

        local width = 5
        local height = 1
        local row = 0
        local col = vim.o.columns - width

        startTimer.run()
        async.run(function()
                while true do
                        async.util.sleep(6000)
                        if not vim.api.nvim_buf_is_valid(buf) then
                                break
                        end
                        vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
                                startTimer.timeSpent or "00:00",
                        })
                end
        end)
        -- vim.api.nvim_buf_set_option(buf, "modifiable", false)

        local opts = {
                relative = "editor", -- or "win", "cursor"
                width = width,
                height = height,
                row = row,
                col = col,
                style = "minimal", -- no line numbers, statusline, etc.
                border = "single", -- or "single", "double", "none"
        }

        local win = vim.api.nvim_open_win(buf, false, opts)
        M.created = true
        function M.close()
                if win and vim.api.nvim_win_is_valid(win) then
                        return
                end

                if buf and vim.api.nvim_buf_is_valid(buf) then
                        return
                end

                vim.api.nvim_win_close(win, true) -- closes the floating window
                vim.api.nvim_buf_delete(buf, { force = true }) -- deletes the buffer
        end
end

return M
