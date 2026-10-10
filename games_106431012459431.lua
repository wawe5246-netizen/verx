local verx = shared.verx
local loadstring = function(...)
    local Chunk, Message = loadstring(...)
    if Message and verx then
        verx:CreateNotifiverxion("Verx", `Failed to load : {Message}`, 30, "alert")
    end
    return Chunk
end
local isfile = isfile or function(File: string)
    local Success, Result = pcall(function()
        return readfile(File)
    end)
    return Success and Result ~= nil and Result ~= ""
end
local function DownloadFile(FilePath: string, Func)
    if not isfile(FilePath) then
        local Success, Result = pcall(function()
            return game:HttpGet(`https://api.verx.dev/download/src/{select(1, FilePath:gsub(`^{verx.Directory}/`, ""))}`, true)
        end)
        if not Success or Result == "404: Not Found" then
            error(Result)
        end
        if FilePath:find(".lua") then
            Result = `--This watermark is used to delete the file if its cached, remove it to make the file persist after verx updates.\n{Result}`
        end
        writefile(FilePath, Result)
    end
    return (Func or readfile)(FilePath)
end

verx.Place = 16483433878
loadstring(DownloadFile(`{verx.Directory}/games/{verx.Place}.lua`), "blocktales")()