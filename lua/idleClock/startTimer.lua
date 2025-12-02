local async = require("plenary.async")

local M = {}

M.timeSpent = "00:00"
M.stop = false
function M.run()




local function format_time(seconds)
    local mins = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d", mins, secs)
end



local function startTimer()
    M.stop = false
    async.run(function()
        local elapsed = 0
        while true do
            async.util.sleep(6000)
            -- print(" 6 seconds has been passed")
            elapsed = elapsed + 6

            M.timeSpent = format_time(elapsed)

            if M.stop == true then
                break
            end
        end
    end)
end

startTimer()
end

return M