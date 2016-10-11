#!/usr/bin/ruby

input = ENV['POPCLIP_TEXT'].strip.split(':')

min = input[0].to_i * 60 + input[1].to_i

if input.length > 2 then
	if input[2].to_i > 30 then
		min += 1
	end
end

print min
