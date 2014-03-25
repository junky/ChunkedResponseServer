# encoding: utf-8

require 'socket'

def sent_headers(client)
	  client.puts File.read('headers.txt', :encoding => "UTF-8")
end

def sent_chunk(client, text, index)
  puts "#{index} : #{text.bytesize.to_s(16)}"
  begin
    client.puts "#{text.bytesize.to_s(16)}\r"
    client.puts "#{text}\r"
    sleep(1)
  rescue Errno::EPIPE
    puts 'Broken pipe (Errno::EPIPE)'
  end
end

def sent_last_chunk(client)
  sent_chunk(client, '', 0)
end

server = TCPServer.new 2745
loop do
  client = server.accept    # Wait for a client to connect
 
  input_header = client.gets
  m = /chunk-index=(?<index>\d+)/.match(input_header)
  index = -1
  index = m[:index].to_i if !m.nil?
  puts index
  
  sent_headers(client);


  file_content = File.read('content.txt', :encoding => "UTF-8")
  file_content.insert(index, '-|-') if index >= 0
  chunks = file_content.split('-|-')
  
  i=0 
  chunks.each { |c| sent_chunk(client, c, i); i=i+1}
  
  sent_last_chunk(client)
  sleep(2) 
  client.close
end