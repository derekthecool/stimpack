package.loaded['stimpack.boosters.log-timestamp-visualizer'] = nil
local ltv = require('stimpack.boosters.log-timestamp-visualizer')

local parsed_time_1 = ltv.parse_time_string('2024-03-28 10:14:35.814 -06:00')
print(parsed_time_1)

local parsed_time_2 = ltv.parse_time_string('2024-03-29 10:14:35.000 -06:00')
print(parsed_time_2)

local dateTimeDifference = ltv.dateTimeDifferenceSeconds(parsed_time_1, parsed_time_2)
print(dateTimeDifference)
