-- @description Paste Track Color (from extstate)
-- @version 1.0
-- @author Denny Podemirov
-- @about
--   Applies the track color saved previously via Copy Track Color
--   to all selected tracks.
-- @provides
--   [main] Scripts > Paste-Track-Color.lua
-- @link https://github.com/dennypodemirov/Denny-Podemirov-Reascripts

local val = reaper.GetExtState("TrackColorTool", "lastColor")
if val == "" then return end

local color = tonumber(val)
if not color then return end

color = color | 0x1000000

local count = reaper.CountSelectedTracks(0)
for i = 0, count - 1 do
  local track = reaper.GetSelectedTrack(0, i)
  reaper.SetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR", color)
end

reaper.TrackList_AdjustWindows(false)
