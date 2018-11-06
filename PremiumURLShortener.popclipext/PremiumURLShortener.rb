#!/usr/bin/ruby

require 'net/http'
require 'json'

Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

input = ENV['POPCLIP_TEXT'].to_s.strip()
API = ENV['POPCLIP_OPTION_APIKEY'].to_s.strip()
address = ENV['POPCLIP_OPTION_ADDRESS'].to_s.strip()

short = JSON.parse(Net::HTTP.get(URI('http://' + address + '/api?key=' + API + '&url=' + input)))
if short["error"] == 0 then
  print short["short"]
else
  print "An error happened:  "
  print short["error"]
  print "\n"
end
