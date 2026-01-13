# frozen_string_literal: true

require 'socket'
require 'byebug'

server = TCPServer.new 3001

puts "Server Listening #{server.inspect}"

loop do
  require_relative 'request'

  client = server.accept
  puts "debugging client #{client.inspect}"
  # Read HTTP request
  request_line = client.gets
  puts "Received: #{request_line.inspect}"

  begin
    # Parse Rest
    request = Tulip::Request.parse_request(request_line)
    puts "Request: #{request}"
  rescue StandardError => e
    puts e.message
  end

  # Send HTTP response
  client.puts 'HTTP/1.1 200 OK'
  client.puts 'Content-Type: Application/json'
  client.puts ''

  if request[:path] == '/hello'
    client.puts "{\"message\" : \"hi\", \"time\" : \"#{Time.now}\" }"
  else
    client.puts "{\"message\" : \"home\", \"time\" : \"#{Time.now}\" }"
  end

  client.close
end
