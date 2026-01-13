require 'socket'
require 'byebug'

server = TCPServer.new 2000 

loop do
  require_relative 'request'

  client = server.accept 

  # Read HTTP request
  request_line = client.gets
  puts "Received: #{request_line.inspect}"

  begin
  # Parse Rest
  # byebug
  request = Tulip::Request.parse_request(request_line)
  puts "Request: #{request}"
  rescue StandardError => e
    puts e.message
  end

  # Send HTTP response
  client.puts "HTTP/1.1 200 OK"   
  client.puts "Content-Type: Application/json"
  client.puts ""

  if request[:path] == '/hello'
    client.puts '{"message" : "Hiii", "time" : "' + Time.now.to_s + '" }'
  else
    client.puts '{"message" : "home", "time" : "' + Time.now.to_s + '" }'
  end

  client.close
end
