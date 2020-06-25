class Machine < ApplicationRecord

  require 'socket'

  def self.connect
    "Hello"
  end

  def self.play
    socket = TCPSocket.open("192.168.1.168", 9993)
    socket.puts "play\n"
    messages = read_message(socket)
    socket.close
    messages
  end

  def self.stop
    socket = TCPSocket.open("192.168.1.168", 9993)
    socket.puts "stop\r\n"
    messages = read_message(socket)
    socket.close
    messages
  end
  
  private
  def self.read_message(sock)
    lines = []
    while (line = sock.gets) && line.chomp != '' # While the client is connected, and hasn't sent us a blank line yet...
      lines << line.chomp
    end
    lines
  end
  
end
