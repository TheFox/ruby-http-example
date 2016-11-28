#!/usr/bin/env ruby

require 'uri'
require 'net/http'
require 'openssl'

url = URI.parse('http://example.com')
# url = URI.parse('https://example.com')
# url = URI.parse('https://example.com/404')

puts "url: '#{url}'"

http = Net::HTTP.new(url.host, url.port)
http.ssl_timeout = 5
if url.scheme.to_s.downcase == 'https'
	puts 'HTTPS request'
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
end
req = Net::HTTP::Get.new(url)
res = http.request(req)

puts "response code: #{res.code}"
if res.code.to_i == 200
	puts 'response OK'
else
	puts 'response FAILED'
end
