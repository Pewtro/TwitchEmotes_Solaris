local AddonName, TwitchEmotes_Solaris = ...

local autocompleteInited = false

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end

function TwitchEmotes_Solaris:SetAutoComplete(state)
    TwitchEmotes_Solaris_Settings["FEAT_AUTOCOMPLETE"] = state

    if TwitchEmotes_Solaris_Settings["FEAT_AUTOCOMPLETE"] and not autocompleteInited then
        
        local i = tablelength(AllTwitchEmoteNames);
        for k, v in pairs(TwitchEmotes_Solaris_Emoticons_Pack) do
            AllTwitchEmoteNames[i] = k;
            i = i + 1;
        end

        --Sort the list alphabetically
        table.sort(AllTwitchEmoteNames)

        for i=1, NUM_CHAT_WINDOWS do
            local frame = _G["ChatFrame"..i]

            local editbox = frame.editBox;
            local suggestionList = AllTwitchEmoteNames;
            local maxButtonCount = 20;

            local autocompletesettings = {
                perWord = true,
                activationChar = ':',
                closingChar = ':',
                minChars = 2,
                fuzzyMatch = true,
                onSuggestionApplied = function(suggestion)
                    --UpdateEmoteStats(suggestion, true, false, false);
                end,
                renderSuggestionFN = TwitchEmotes_Solaris_RenderSuggestion,
                suggestionBiasFN = function(suggestion, text)
                    ----Bias the sorting function towards the most autocompleted emotes
                    --if TwitchEmoteStatistics[suggestion] ~= nil then
                    --    return TwitchEmoteStatistics[suggestion][1] * 5
                    --end
                    return 0;
                end,
                interceptOnEnterPressed = true,
                addSpace = true,
                useTabToConfirm = TwitchEmotes_Solaris_Settings["FEAT_AUTOCOPLETE_WITH_TAB"],
                useArrowButtons = true,
            }

            SetupAutoComplete(editbox, suggestionList, maxButtonCount, autocompletesettings);
            
        end
    
        autocompleteInited = true;
    end

end


--this function transforms the text in the autocomplete suggestions (we add the emote image here)
function TwitchEmotes_Solaris_RenderSuggestion(text)
    local fullEmotePath = TwitchEmotes_Solaris_Emoticons_Pack[text];
    if (not fullEmotePath) then
       fullEmotePath = TwitchEmotes_defaultpack[text]
    end
    if(fullEmotePath ~= nil) then
        local size = string.match(fullEmotePath, ":(.*)")
        local path_and_size = "";
        if(size ~= nil) then
            path_and_size = string.gsub(fullEmotePath, size, "16:16")
        else
            path_and_size = fullEmotePath .. "16:16";
        end
        return "|T".. path_and_size .."|t " .. text;
    end
end