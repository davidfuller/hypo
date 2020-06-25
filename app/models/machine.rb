class Machine < ApplicationRecord

  require 'socket'

  def self.connect
    "Hello"
  end

  def self.play
    socket = TCPSocket.open("192.168.1.168", 9993)
    socket.puts "play\n"
    a = []
    while message = socket.gets             # Read lines from the socket
      a.push(message.chomp)
    end
    socket.close
    a
  end

  def self.stop
    socket = TCPSocket.open("192.168.1.168", 9993)
    socket.puts "stop\n"
    socket.close
    "Done"
  end
end
