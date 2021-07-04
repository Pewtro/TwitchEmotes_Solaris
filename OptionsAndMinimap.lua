---@diagnostic disable: deprecated
local AddonName, TwitchEmotes_Solaris = ...

-- Main Frame settings
TwitchEmotes_Solaris.BackdropColor = {0.058823399245739, 0.058823399245739, 0.058823399245739, 0.9}

-- Create minimap button
local minimapHeadingColor = "|cFFFFFFFF"

local icon = LibStub("LibDBIcon-1.0")
local db
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("TwitchEmotes_Solaris", {
    type = "data source",
    text = "Twitch Emotes Solaris",
    icon = "Interface\\AddOns\\"..AddonName.."\\UI\\solaris",
    OnClick = function(_, buttonPressed)
        if buttonPressed == "RightButton" then
            if db.minimap.lock then
                icon:Unlock("TwitchEmotes_Solaris")
            else
                icon:Lock("TwitchEmotes_Solaris")
            end
        else
            TwitchEmotes_Solaris:ShowInterface()
        end
    end,
    OnTooltipShow = function(tooltip)
        if not tooltip or not tooltip.AddLine then
            return
        end
        tooltip:AddLine(minimapHeadingColor .. "Twitch Emotes Solaris|r")
        tooltip:AddLine("Click to toggle AddOn Window")
        tooltip:AddLine("Right-click to lock Minimap Button")
    end
})

-- Init
local defaultSavVar = {
    global = {
        minimap = {
            hide = false
        },
        scale = 1,
    }
}
do
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, ...)
        return TwitchEmotes_Solaris[event](self, ...)
    end)

    function TwitchEmotes_Solaris.ADDON_LOADED(self, addon)
        if addon == "TwitchEmotes_Solaris" then
            db = LibStub("AceDB-3.0"):New("TwitchEmotes_SolarisDB", defaultSavVar).global
            icon:Register("TwitchEmotes_Solaris", LDB, db.minimap)
            if not db.minimap.hide then
                icon:Show("TwitchEmotes_Solaris")
            end
        end
        TwitchEmotes_Solaris:RegisterOptions()
        self:UnregisterEvent("ADDON_LOADED")

    end
end

function TwitchEmotes_Solaris:RegisterOptions()
    TwitchEmotes_Solaris.blizzardOptionsTable = {
        name = "Twitch Emotes Solaris",
        type = "group",
        args = {
            enable = {
                type = 'toggle',
                name = "Enable Minimap Button",
                desc = "If the Minimap Button is enabled",
                get = function()
                    return not db.minimap.hide
                end,
                set = function(_, newValue)
                    db.minimap.hide = not newValue
                    if not db.minimap.hide then
                        icon:Show("TwitchEmotes_Solaris")
                    else
                        icon:Hide("TwitchEmotes_Solaris")
                    end
                end,
                order = 1,
                width = "full"
            }
        }
    }
    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("TwitchEmotes_Solaris",
        TwitchEmotes_Solaris.blizzardOptionsTable)
    self.blizzardOptionsMenu = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TwitchEmotes_Solaris",
        "TwitchEmotes_Solaris")
end

local framesInitialized
function TwitchEmotes_Solaris:ShowInterface()
    if not framesInitialized then
        print("initializing frames")
        framesInitialized = true
    end
    print("show interface")
    --[[
    if self.main_frame:IsShown() then
        TwitchEmotes_Solaris:HideInterface()
    else
        self.main_frame:Show()
    end
    --]]
end

--[[
function TwitchEmotes_Solaris:HideInterface()
    self.main_frame:Hide()
end
--]]