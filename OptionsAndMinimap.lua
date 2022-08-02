---@diagnostic disable: deprecated
local AddonName, TwitchEmotes_Solaris = ...

local LDB = LibStub("LibDataBroker-1.1")
local LDBIcon = LibStub("LibDBIcon-1.0")

TwitchEmotes_Solaris_Settings = {
    ["MINIMAP_SHOW"] = false,
    ["MINIMAP_LOCK"] = false,
    ["MINIMAP_DATA"] = {
        minimapPos = 130
    },

    --Features
    ["FEAT_AUTOCOMPLETE"] = true,
    ["FEAT_AUTOCOPLETE_WITH_TAB"] = false,
}

local defaultSettings = {
    ["MINIMAP_SHOW"] = false, --TODO
    ["MINIMAP_LOCK"] = false,
    ["MINIMAP_DATA"] = {
        minimapPos = 130
    },

    ["FEAT_AUTOCOMPLETE"] = true,
    ["FEAT_AUTOCOPLETE_WITH_TAB"] = false, --TODO
}

-- Main Frame settings

-- Create minimap button
local minimapHeadingColor = "|cFFFFFFFF"
local minimapIconRegistered = false

local Broker_TwitchEmotes_Solaris = LDB:NewDataObject("TwitchEmotes_Solaris", {
    type = "data source",
    text = "Twitch Emotes Solaris",
    icon = "Interface\\AddOns\\"..AddonName.."\\UI\\solaris",
    OnClick = function(_, buttonPressed)
        if buttonPressed == "RightButton" then
            if TwitchEmotes_Solaris_Settings["MINIMAP_LOCK"] then
                LDBIcon:Unlock("TwitchEmotes_Solaris")
                TwitchEmotes_Solaris_Settings["MINIMAP_LOCK"] = false
            else
                LDBIcon:Lock("TwitchEmotes_Solaris")
                TwitchEmotes_Solaris_Settings["MINIMAP_LOCK"] = true
            end
        -- else
        --    TwitchEmotes_Solaris:ShowInterface()
        end
    end,
    OnTooltipShow = function(tooltip)
        if not tooltip or not tooltip.AddLine then
            return
        end
        tooltip:AddLine(minimapHeadingColor .. "Twitch Emotes Solaris|r")
        --tooltip:AddLine("Click to toggle AddOn Window")
        tooltip:AddLine("Right-click to lock Minimap Button")
    end
})

-- Init
do
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, ...)
        return TwitchEmotes_Solaris[event](self, ...)
    end)

    function TwitchEmotes_Solaris.ADDON_LOADED(self, addon)
        if addon == "TwitchEmotes_Solaris" then
            -- Ensure defaults if nil
            for k, v in pairs(defaultSettings) do
                if (TwitchEmotes_Solaris_Settings[k] == nil) then
                    TwitchEmotes_Solaris_Settings[k] = v;
                end
            end
            
            LDBIcon:Register("TwitchEmotes_Solaris", Broker_TwitchEmotes_Solaris,
                TwitchEmotes_Solaris_Settings["MINIMAP_DATA"])
            minimapIconRegistered = true
            
            TwitchEmotes_Solaris:SetMinimapButton(TwitchEmotes_Solaris_Settings["MINIMAP_SHOW"])
            TwitchEmotes_Solaris:SetAutoComplete(TwitchEmotes_Solaris_Settings["FEAT_AUTOCOMPLETE"])

            --TODO
            --TwitchEmotes_Solaris:RegisterOptions()
            self:UnregisterEvent("ADDON_LOADED")
        end
    end
end

function TwitchEmotes_Solaris:SetMinimapButton(state)
    TwitchEmotes_Solaris_Settings["MINIMAP_SHOW"] = state;

    if(state) then

        if not minimapIconRegistered then
            LDBIcon:Register("TwitchEmotes_Solaris", Broker_TwitchEmotes_Solaris,
                TwitchEmotes_Solaris_Settings["MINIMAP_DATA"])
            minimapIconRegistered = true
        end

        LDBIcon:Show("TwitchEmotes_Solaris")
    else
        LDBIcon:Hide("TwitchEmotes_Solaris")
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
                    return TwitchEmotes_Solaris_Settings["MINIMAP_SHOW"]
                end,
                set = function(_, newValue)
                    TwitchEmotes_Solaris_Settings["MINIMAP_SHOW"] = newValue
                    if TwitchEmotes_Solaris_Settings["MINIMAP_SHOW"] then
                        LDBIcon:Show("TwitchEmotes_Solaris")
                    else
                        LDBIcon:Hide("TwitchEmotes_Solaris")
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
    local isShown = false
    if isShown then
        TwitchEmotes_Solaris:HideInterface()
    else
        print("show interface")
        --some command to show interface
    end
    
end


function TwitchEmotes_Solaris:HideInterface()
    print("hide interface")
    -- some command to hide interface
end
