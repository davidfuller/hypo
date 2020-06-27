class Machine < ApplicationRecord

  require 'socket'

  def connect
    @socket = TCPSocket.open(self.ip, self.port)
    read_messages
  end
  
  def socket
    @socket
  end
  
  def close
    @socket.puts "quit\r\n\r\n"
    @socket.close
    @socket = nil
    "Closed"
  end
  
  def play
    messages = connect
    @socket.puts "play\n\n"
    messages << read_message
    messages << close
  end

  def self.stop
    @socket.puts "stop\r\n\r\n"
    read_message
  end
  
  def self.info
    @socket.puts "transport info\r\n"
    read_messages
  end

  def is_connected
    !@socket.nil?
  end
  
  private
  def read_messages
    lines = []
    while (line = @socket.gets) && line.chomp != '' # While the client is connected, and hasn't sent us a blank line yet...
      lines << line.chomp
    end
    lines
  end
  
  def read_message
    @socket.gets
  end
  
end
