-- @description Paste HEX Color (input)
-- @version 1.0
-- @author Denny Podemirov
-- @about
--   Prompts the user for a HEX color (RRGGBB) and applies it
--   to all selected tracks.
-- @link https://github.com/dennypodemirov/reaper-scripts
-- @changelog
--   v1.0 - Initial release


local retval, input = reaper.GetUserInputs("HEX Color", 1, "Enter HEX (RRGGBB):", "")
if not retval or input == "" then return end

input = input:gsub("#", ""):upper()

if input:match("^%x%x%x%x%x%x$") then
  local r = tonumber(input:sub(1,2), 16)
  local g = tonumber(input:sub(3,4), 16)
  local b = tonumber(input:sub(5,6), 16)
  local color = r + g*256 + b*65536

  local count = reaper.CountSelectedTracks(0)
  for i = 0, count - 1 do
    local track = reaper.GetSelectedTrack(0, i)
    reaper.SetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR", color | 0x1000000)
  end

  reaper.TrackList_AdjustWindows(false)
else
  reaper.ShowMessageBox("Invalid HEX format! Please enter 6 characters, for example: FF8800", "Error", 0)
end