std = "lua51"
ignore = {
    "11./SLASH_.*", -- Setting an undefined (Slash handler) global variable
	"11./BINDING_.*", -- Setting an undefined (Keybinding header) global variable
	"113/LE_.*", -- Accessing an undefined (Lua ENUM type) global variable
	"113/NUM_LE_.*", -- Accessing an undefined (Lua ENUM type) global variable
	"211", -- Unused local variable
	"211/L", -- Unused local variable "L"
	"211/CL", -- Unused local variable "CL"
	"212", -- Unused argument
	"213", -- Unused loop variable
	"214", -- unused hint
	"311", -- Value assigned to a local variable is unused
	"314", -- Value of a field in a table literal is unused
	"42.", -- Shadowing a local variable, an argument, a loop variable.
	"43.", -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
	"542", -- An empty if branch
	"581", --  error-prone operator orders
	"582", --  error-prone operator orders
    "611", -- whitespace only line
}
globals = {
    -- OWN --
    --Emotes
    "TwitchEmotes_Solaris_Emoticons",
    "TwitchEmotes_Solaris_Emoticons_Pack",
    --Others
    "TwitchEmotes_Solaris_Settings",
    "TwitchEmotes_Solaris_RenderSuggestion",

    -- OTHERS -- 

    --Twitch Emotes v2
    "Emoticons_RegisterPack",
    "AllTwitchEmoteNames",
    "TwitchEmotes_defaultpack",

    --Misc / Libs 
    "LibStub",
    "SetupAutoComplete",

    --FrameXML Misc
    "CreateFrame",

    --Blizz
    "NUM_CHAT_WINDOWS",
}