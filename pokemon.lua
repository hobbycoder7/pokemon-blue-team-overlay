-- http://stackoverflow.com/questions/20325332/how-to-check-if-two-tablesobjects-have-the-same-value-in-lua
local function is_table_equal(t1,t2,ignore_mt)
   local ty1 = type(t1)
   local ty2 = type(t2)
   if ty1 ~= ty2 then return false end
   -- non-table types can be directly compared
   if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
   -- as well as tables which have the metamethod __eq
   local mt = getmetatable(t1)
   if not ignore_mt and mt and mt.__eq then return t1 == t2 end
   for k1,v1 in pairs(t1) do
      local v2 = t2[k1]
      if v2 == nil or not is_table_equal(v1,v2) then return false end
   end
   for k2,v2 in pairs(t2) do
      local v1 = t1[k2]
      if v1 == nil or not is_table_equal(v1,v2) then return false end
   end
   return true
end

function SavePartyToFile(party)
    local party_string = "var pokemon_data = {\"party\":["
    for k,v in ipairs(party) do
        party_string = party_string .. string.format("{\"id\":\"%s\",\"level\":\"%s\",\"nickname\":\"%s\"}", party[k]['id'], party[k]['level'],  party[k]['nickname']) .. ','
    end
    party_string = party_string:sub(1,-2)
    party_string = party_string .. "]}"
    local file = io.open("pokemon.json", "w")
    file:write(party_string)
    file:close()
    print("Party Saved.")
end

local party = {}
-- http://datacrystal.romhacking.net/wiki/Pok%C3%A9mon_Red/Blue:RAM_map#Player
local memory_addresses = {
    [1] = {["id"] = 0xD164, ["level"] = 0xD18C, ["nickname"] = 0xD2B5},
    [2] = {["id"] = 0xD165, ["level"] = 0xD1B8, ["nickname"] = 0xD2C0},
    [3] = {["id"] = 0xD166, ["level"] = 0xD1E4, ["nickname"] = 0xD2CB},
    [4] = {["id"] = 0xD167, ["level"] = 0xD210, ["nickname"] = 0xD2D6},
    [5] = {["id"] = 0xD168, ["level"] = 0xD23C, ["nickname"] = 0xD2E1},
    [6] = {["id"] = 0xD169, ["level"] = 0xD268, ["nickname"] = 0xD2EC}
}


-- http://datacrystal.romhacking.net/wiki/Pok%C3%A9mon_Red_and_Blue:TBL
local text_table = {
["4F"] = "",
["57"] = "#",
["50"] = "TERMINATOR_CHARACTER",
["51"] = "*",
["52"] = "A1",
["53"] = "A2",
["54"] = "POKé",
["55"] = "+",
["58"] = "$",
["75"] = "…",
["7F"] = " ",
["80"] = "A",
["81"] = "B",
["82"] = "C",
["83"] = "D",
["84"] = "E",
["85"] = "F",
["86"] = "G",
["87"] = "H",
["88"] = "I",
["89"] = "J",
["8A"] = "K",
["8B"] = "L",
["8C"] = "M",
["8D"] = "N",
["8E"] = "O",
["8F"] = "P",
["90"] = "Q",
["91"] = "R",
["92"] = "S",
["93"] = "T",
["94"] = "U",
["95"] = "V",
["96"] = "W",
["97"] = "X",
["98"] = "Y",
["99"] = "Z",
["9A"] = "(",
["9B"] = ")",
["9C"] = ":",
["9D"] = ";",
["9E"] = "[",
["9F"] = "]",
["A0"] = "a",
["A1"] = "b",
["A2"] = "c",
["A3"] = "d",
["A4"] = "e",
["A5"] = "f",
["A6"] = "g",
["A7"] = "h",
["A8"] = "i",
["A9"] = "j",
["AA"] = "k",
["AB"] = "l",
["AC"] = "m",
["AD"] = "n",
["AE"] = "o",
["AF"] = "p",
["B0"] = "q",
["B1"] = "r",
["B2"] = "s",
["B3"] = "t",
["B4"] = "u",
["B5"] = "v",
["B6"] = "w",
["B7"] = "x",
["B8"] = "y",
["B9"] = "z",
["BA"] = "é",
["BB"] = "'d",
["BC"] = "'l",
["BD"] = "'s",
["BE"] = "'t",
["BF"] = "'v",
["E0"] = "'",
["E1"] = "PK",
["E2"] = "MN",
["E3"] = "-",
["E4"] = "'r",
["E5"] = "'m",
["E6"] = "?",
["E7"] = "!",
["E8"] = ".",
["ED"] = "→",
["EE"] = "↓",
["EF"] = "♂",
["F0"] = "¥",
["F1"] = "×",
["F3"] = "/",
["F4"] = ",",
["F5"] = "♀",
["F6"] = "0",
["F7"] = "1",
["F8"] = "2",
["F9"] = "3",
["FA"] = "4",
["FB"] = "5",
["FC"] = "6",
["FD"] = "7",
["FE"] = "8",
["FF"] = "9"
}
-- http://snipplr.com/view/13086/number-to-hex/
--- Returns HEX representation of num
function num2hex(num)
    local hexstr = '0123456789ABCDEF'
    local s = ''
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    if s == '' then s = '0' end
    return s
end

-- http://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_index_number_(Generation_I)
while true do
    local temp_party = {}
    for i = 1,6 do
        local pokemon_id = memory.readbyte(memory_addresses[i]["id"])
        local pokemon_level = memory.readbyte(memory_addresses[i]["level"])
        local pokemon_nickname = ""
        if ( pokemon_id == 255 ) then
            pokemon_nickname = "Empty";
        else
            pokemon_nickname_table = memory.readbyterange(memory_addresses[i]["nickname"],10)
            for x, char_int in ipairs(pokemon_nickname_table) do
                local char = text_table[num2hex(char_int)]
                if ( char == "TERMINATOR_CHARACTER") then
                    break
                else
                    pokemon_nickname = pokemon_nickname .. char
                end
            end
        end
        table.insert(temp_party, {["id"] = pokemon_id, ["level"] = pokemon_level, ["nickname"] = pokemon_nickname})
    end
    if is_table_equal(party, temp_party) == false then
        party = temp_party
        print("Party changed: ")
        print(party)
        SavePartyToFile(party)
    end
    vba.frameadvance()
end
