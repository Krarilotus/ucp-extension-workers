
local DEFAULT_WORKER_COUNT = {
  ["CHURCH"]              = 2,
  ["CATHEDRAL"]           = 2,
  
}

local BUILDING_TYPES = {

  ["HOVEL"] = 0x1,
  ["HOUSE"] = 0x2,
  ["WOODCUTTERSHUT"] = 0x3,
  ["OXTETHER"] = 0x4,
  ["IRONMINE"] = 0x5,
  ["PITCHRIG"] = 0x6,
  ["HUNTERSHUT"] = 0x7,
  ["MERCENARYPOST"] = 0x8,
  ["BARRACKS"] = 0x9,
  ["STOCKPILE"] = 0xa,
  ["ARMORY"] = 0xb,
  ["FLETCHER"] = 0xc,
  ["BLACKSMITH"] = 0xd,
  ["POLETURNER"] = 0xe,
  ["ARMOURER"] = 0xf,
  ["TANNER"] = 0x10,
  ["BAKERY"] = 0x11,
  ["BREWERY"] = 0x12,
  ["GRANARY"] = 0x13,
  ["QUARRY"] = 0x14,
  ["QUARRYSTOCKPILE"] = 0x15,
  ["INN"] = 0x16,
  ["APOTHECARY"] = 0x17,
  ["ENGINEERSGUILD"] = 0x18,
  ["TUNNELERSGUILD"] = 0x19,
  ["MARKETPLACE"] = 0x1a,
  ["WELL"] = 0x1b,
  ["OILSMELTER"] = 0x1c,
  ["SIEGETENT"] = 0x1d,
  ["WHEATFARM"] = 0x1e,
  ["HOPFARM"] = 0x1f,
  ["APPLEFARM"] = 0x20,
  ["DAIRYFARM"] = 0x21,
  ["MILL"] = 0x22,
  ["STABLES"] = 0x23,
  ["CHAPEL"] = 0x24,
  ["CHURCH"] = 0x25,
  ["CATHEDRAL"] = 0x26,
  ["UNKNOWN1"] = 0x27,
  ["MANORHOUSE"] = 0x28,
  ["STONEKEEP"] = 0x29,
  ["STRONGHOLD"] = 0x2a,
  ["KEEPFOUR"] = 0x2b,
  ["KEEPFIVE"] = 0x2c,
  ["GATEHOUSELARGE"] = 0x2d,
  ["GATEHOUSESMALL"] = 0x2e,
  ["WOODGATE1"] = 0x2f,
  ["WOODGATE2"] = 0x30,
  ["DRAWBRIDGE"] = 0x31,
  ["TUNNEL"] = 0x32,
  ["CAMPFIRE"] = 0x33,
  ["SIGNPOST"] = 0x34,
  ["PARADEGROUND"] = 0x35,
  ["FIREBALLISTA"] = 0x36,
  ["CAMPGROUND"] = 0x37,
  ["PARADEGROUND2"] = 0x38,
  ["PARADEGROUND3"] = 0x39,
  ["PARADEGROUND4"] = 0x3a,
  ["PARADEGROUND5"] = 0x3b,
  ["GATEHOUSE"] = 0x3c,
  ["TOWER"] = 0x3d,
  ["GALLOWS"] = 0x3e,
  ["STOCKS"] = 0x3f,
  ["WITCHHOIST"] = 0x40,
  ["MAYPOLE"] = 0x41,
  ["GARDEN"] = 0x42,
  ["KILLINGPIT"] = 0x43,
  ["PITCHDITCH"] = 0x44,
  ["SIEGETOWER_PLACED"] = 0x45,
  ["WATERPOT"] = 0x46,
  ["KEEPDOOR_LEFT"] = 0x47,
  ["KEEPDOOR_RIGHT"] = 0x48,
  ["KEEPDOOR"] = 0x49,
  ["TOWER1"] = 0x4a,
  ["TOWER2"] = 0x4b,
  ["TOWER3"] = 0x4c,
  ["TOWER4"] = 0x4d,
  ["TOWER5"] = 0x4e,
  ["UNKNOWN3"] = 0x4f,
  ["CATAPULT"] = 0x50,
  ["TREBUCHET"] = 0x51,
  ["BATTERINGRAM"] = 0x52,
  ["SIEGETOWER"] = 0x53,
  ["SHIELD"] = 0x54,
  ["UNKNOWN4"] = 0x55,
  ["MANGONEL"] = 0x56,
  ["BALLISTA"] = 0x57,
  ["UNKNOWN5"] = 0x58,
  ["UNKNOWN6"] = 0x59,
  ["UNKNOWN7"] = 0x5a,
  ["CESSPIT"] = 0x5b,
  ["BURNINGSTAKE"] = 0x5c,
  ["GIBBET"] = 0x5d,
  ["DUNGEON"] = 0x5e,
  ["STRETCHINGRACK"] = 0x5f,
  ["RACKFLOGGING"] = 0x60,
  ["CHOPPINGBLOCK"] = 0x61,
  ["DUNKINGSTOOL"] = 0x62,
  ["DOGCAGE"] = 0x63,
  ["STATUE"] = 0x64,
  ["SHRINE"] = 0x65,
  ["BEEHIVE"] = 0x66,
  ["DANCINGBEAR"] = 0x67,
  ["POND"] = 0x68,
  ["BEARCAVE"] = 0x69,
  ["OUTPOST"] = 0x6a,
  ["OUTPOST_ARABIAN"] = 0x6b,

}

local addressEmployeeCountPerBuildingType

return {
  enable = function(self, config)
    
    -- int[110]
    local _, employeeCountPerBuildingType = utils.AOBExtract("66 ? ? ? I(? ? ? ?) 66 89 90 C6 00 00 00")
    addressEmployeeCountPerBuildingType = employeeCountPerBuildingType
    
    log(0, string.format("address: %X", addressEmployeeCountPerBuildingType))

    if config.workercounts.cathedral.value == true then
       self:setWorkersForBuilding("CATHEDRAL", 2)    
    end
    
    if config.workercounts.church.value == true then
       self:setWorkersForBuilding("CHURCH", 2)    
    end
    
    -- for k, v in pairs(DEFAULT_WORKER_COUNT) do
      -- self:setWorkersForBuilding(k, v)
    -- end

  
  end,
  
  setWorkersForBuilding = function(self, buildingType, workers)
    core.writeInteger(addressEmployeeCountPerBuildingType + (4*BUILDING_TYPES[buildingType]), workers)
  end,
  
  disable = function() end,

}, {
  public = {
    "setWorkersForBuilding",
  }

}