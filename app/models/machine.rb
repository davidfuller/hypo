class Machine < ApplicationRecord

  require 'socket'

  def self.connect
    @socket = TCPSocket.open("192.168.1.168", 9993)
    read_message
  end
  
  def self.close
    @socket.close
    "Closed"
  end
  
  def self.play
    @socket.puts "play\n"
    read_message
  end

  def self.stop
    @socket.puts "stop\r\n"
    read_message
  end
  
  private
  def self.read_message
    lines = []
    while (line = @socket.gets) && line.chomp != '' # While the client is connected, and hasn't sent us a blank line yet...
      lines << line.chomp
    end
    lines
  end
  
end
