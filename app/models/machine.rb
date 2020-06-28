class Machine < ApplicationRecord

  require 'socket'

  def connect
    #@socket = TCPSocket.open(self.ip, self.port)
    begin
      @status = 'Good'
      @socket = Socket.tcp(self.ip, self.port, nil, nil, connect_timeout: 2 )
      read_messages
    rescue Errno::ETIMEDOUT
      @status = 'Timeout'
    end
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
    if @status == 'Good'
      @socket.puts "play\r\n"
      messages << read_message
      messages << close
    end
    messages << @status
  end

  def stop
    messages = connect
    @socket.puts "stop\r\n"
    messages << read_message
    messages << close
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
    @socket.gets.chomp
  end
  
end
