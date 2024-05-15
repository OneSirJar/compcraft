function center_text(monitor, text, y)
    local width, _ = monitor.getSize()
    local x = math.floor((width - #text) / 2)
    monitor.setCursorPos(x, y)
    monitor.write(text)
end

function print_inventory_on_monitor(chest, monitor)
    monitor.clear()
    monitor.setCursorPos(1, 1)

    local width, height = monitor.getSize()
    local items = chest.list()
    local y = 1

    for slot, item in pairs(items) do
        local itemName = item.name:gsub("minecraft:", "")
        center_text(monitor, itemName, y)
        y = y + 1
        monitor.setTextColor(colors.gray)
        center_text(monitor, "x" .. item.count, y)
        monitor.setTextColor(colors.white)
        y = y + 2
        if y > height then
            break
        end
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("minecraft:chest")

    if monitor and chest then
        print_inventory_on_monitor(chest, monitor)
    else
        print("Monitor of chest niet gevonden")
    end
    sleep(10)
end