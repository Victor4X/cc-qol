t = turtle
p = peripheral

-- Function for counting set values
function setLen(set)
    num = 0
    for k,v in pairs(set) do
        num = num + 1
    end
    return num
end

-- Function that chains multiple
-- callbacks n number of times
-- arg1: number of runs
-- arg2-n: callbacks in order
function chain(n, ...)
    for i=1,n do
        for i,v in ipairs(arg) do
            v()
        end
    end
end

-- Function that does nothing
-- Takes any number of args
-- Returns nil
function noop(...)
return
end

-- Turn turtle X times until
-- nothing is infront of it
--    arg1: true=left, false=right
--    default is right
-- returns amount of turns needed
-- -1 if full rotation, 0 if none
function turnX(left)
    left = left or false
    turns = 0
    while (t.detect()) do
        if (left) then
            t.turnLeft()
        else 
            t.turnRight()
        end
        turns = turns + 1
        if (turns > 3) then
            return -1 
        end
    end
    return turns
end

-- Functions for turning N times
-- Turn right arg1 times
function turnR(n)
    for i=1,n do t.turnRight() end
end
-- Turn left arg1 times
function turnL(n)
    for i=1,n do t.turnLeft() end
end

-- Functions for moving N times
-- Go up arg1 times
function goUp(n)
    for i=1,n do
        t.up()
    end
end

-- Locate item in inventory
-- arg1: string with name of item
-- return: first position with item
--         or -1 if not found
function locateItem(target)
    for i=1,16 do
        item = t.getItemDetail(i)
        if (item) then
            if (item["name"] == target) then
                return i
            end
        end
    end
    return -1
end

-- Locate and move item
-- arg1: string name of item
-- arg2: desired slot
-- return: success bool
function moveByName(item, pos)
    cur = locateItem(item)
    if (cur == -1) then return false end
    if (cur == pos) then return true end
    
    -- If desired slot is occupied
    if (t.getItemCount(pos)) then
        empty = getEmpty()
        if (empty == -1) then
            error("No empty spaces for reorganization")
        end
        t.select(pos)
        t.transferTo(empty)
    end
    t.select(cur)
    t.transferTo(pos)
    return true
end

-- Selects the first empty slot in inv
-- ret1: success bool
function selectEmpty()
    slot = getEmpty()
    if (slot == -1) then return false end
    t.select(slot)
    return true
end

-- Returns the first empty slot in inv
-- ret1: -1 if none, else slot pos
function getEmpty()
    for slot=1,16 do
        count = t.getItemCount(slot)
        if (count == 0) then
            return slot
        end
    end
    return -1
end