#!/usr/bin/ruby

require 'net/http'
require 'json'

Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

input = ENV['POPCLIP_TEXT'].to_s.strip()
API = ENV['POPCLIP_OPTION_APIKEY'].to_s.strip()
address = ENV['POPCLIP_OPTION_ADDRESS'].to_s.strip()

uri = URI('http://' + address + '/api/url/add')
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Post.new(uri.path,{'Content-Type' => 'application/json', 'Authorization' => 'Token ' + API})
req.body = { url: input }.to_json
short = JSON.parse(http.request(req).body)
if short["error"] == 0 then
  print short["short"]
else
  print "An error happened:  "
  print short["error"]
  print "\n"
end
