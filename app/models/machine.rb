class Machine < ApplicationRecord

  require 'socket'

  def self.connect
    "Hello"
  end

  def self.play
    socket = TCPSocket.open("192.168.1.168", 9993)
    socket.puts "play\n"
    a = []
    while (line = socket.gets) && line.chomp != '' # While the client is connected, and hasn't sent us a blank line yet...
      a << line
    end
    socket.close
    a
  end

  def self.stop
    socket = TCPSocket.open("192.168.1.168", 9993)
    socket.puts "stop\n"
    socket.close
    read_message
  end
  
  private
  def self.read_message
    "Done done"
  end
  
end
