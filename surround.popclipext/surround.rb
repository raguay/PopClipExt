#!/usr/bin/ruby

input = ENV['POPCLIP_TEXT']
case ENV['POPCLIP_MODIFIER_FLAGS'].to_i
when 1048576 		# Command
	print "###{input.strip}##"
when 524288 		# Option
	print "<h3>#{input.strip}</h3>"
when 1572864 		# Option-Command
	print "<h1>#{input.strip}</h1>"
else 				# none
	print "**#{input.strip}**"
end
