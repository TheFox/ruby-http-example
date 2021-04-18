#!/usr/bin/env ruby

require 'uri'
require 'net/http'
require 'openssl'

uri = URI.parse('http://example.com')
# uri = URI.parse('https://example.com')
# uri = URI.parse('https://example.com/404')

puts "url: '#{uri}'"

http = Net::HTTP.new(uri.host, uri.port)
http.ssl_timeout = 5
if uri.scheme.to_s.downcase == 'https'
	puts 'HTTPS request'
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
end
response = http.request(Net::HTTP::Get.new(uri))

puts "response code: #{response.code}"
if response.code.to_i == 200
	puts 'response OK'
else
	puts 'response FAILED'
end
