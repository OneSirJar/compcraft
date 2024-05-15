local request = http.get("https://raw.githubusercontent.com/OneSirJar/compcraft/main/chest_monitor.lua")

if (not request) then
    error("")
    return
end

-- Geeft een error als de request faalt
local statusCode = request.getResponseCode()
if (statusCode ~= 200) then
    error("")
    return
end

-- Haalt de inhoud van het bestand op
local chestMonitorContent = request.readAll()
request.close()

-- Schrijft de file contents automatisch
local function writeToFile(fileName, fileContent)
    local file = fs.open(fileName, "w")
    file.write(fileContent)
    file.close()
end

writeToFile("chest_monitor.lua", chestMonitorContent)
writeToFile("startup.lua", [[dofile("chest_monitor.lua")]])

os.reboot()
