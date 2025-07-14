-- @description Copy Track Color (to extstate & HEX clipboard)
-- @version 1.1
-- @author Denny Podemirov
-- @about
--   Copies the selected track’s color to a global extstate,
--   and copies its HEX code (in RGB) to the clipboard.
--   Requires SWS extension to access clipboard.
-- @provides
--   [main] Scripts/DennyPodemirov/Copy Track Color.lua
-- @link https://github.com/dennypodemirov/reaper-scripts
-- @changelog
--   v1.1 - BGR to RGB HEX conversion and clipboard copy added

local track = reaper.GetSelectedTrack(0, 0)
if not track then return end

local color = reaper.GetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR")
color = color & 0xFFFFFF

reaper.SetExtState("TrackColorTool", "lastColor", tostring(color), false)

local function BGRtoHEX(bgr)
  local b = (bgr >> 16) & 0xFF
  local g = (bgr >> 8) & 0xFF
  local r = bgr & 0xFF
  return string.format("%02X%02X%02X", r, g, b)
end

local hex = BGRtoHEX(color)

reaper.CF_SetClipboard(hex)