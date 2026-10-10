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
verx.Place = 1962086868
local FilePath: string = `{verx.Directory}/games/{verx.Place}.lua`
if not isfile(FilePath) then
    local Success, Result = pcall(function()
        return game:HttpGet(`https://api.verx.dev/download/src/{select(1, FilePath:gsub(`^{verx.Directory}/`, ""))}`, true)
    end)
    if not Success or Result == "404: Not Found" then
        error(Result)
    end

    writefile(FilePath, `--This watermark is used to delete the file if its cached, remove it to make the file persist after verx updates.\n{Result}`)
end
loadstring(readfile(FilePath), "towerofhell")()