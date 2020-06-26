class Machine < ApplicationRecord

  require 'socket'

  def self.connect
    @socket = TCPSocket.open("192.168.1.168", 9993)
    read_messages
  end
  
  def self.close
    @socket.close
    @socket = nil
    "Closed"
  end
  
  def self.play
    @socket.puts "play\n\n"
    read_message
  end

  def self.stop
    @socket.puts "stop\r\n\r\n"
    read_message
  end
  
  def self.info
    @socket.puts "transport info\r\n"
    read_messages
  end

  def self.is_connected
    !@socket.nil?
  end
  
  private
  def self.read_messages
    lines = []
    while (line = @socket.gets) && line.chomp != '' # While the client is connected, and hasn't sent us a blank line yet...
      lines << line.chomp
    end
    lines
  end
  
  def self.read_message
    @socket.gets
  end
  
end
