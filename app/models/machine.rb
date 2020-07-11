class Machine < ApplicationRecord

  require 'socket'
  
  has_many :clips

  def connect
    #@socket = TCPSocket.open(self.ip, self.port)
    begin
      @status = 'Good'
      @socket = Socket.tcp(self.ip, self.port, nil, nil, connect_timeout: 2 )
      read_messages
    rescue Errno::ETIMEDOUT
      @status = 'Timeout'
      message = ['Not connected']
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
    simple_command "play\r\n"
  end

  def stop
    simple_command "stop\r\n"
  end
  
  def list
    details = info_command "clips get\r\n"
    results = []
    if details[0] == '205 clips info:'
      details[2..details.length-1].each do |item|
        elements = item.split(' ')
        result = Hash.new
        result[:number] = elements[0].to_i
        result[:duration] = elements[elements.length - 1]
        result[:timecode] = elements[elements.length - 2]
        filename = ''
        elements[1..elements.length-3].each do |section|
          filename = filename + ' ' + section
        end
        result[:filename] = filename.strip
        results << result
      end
    end
    results  
  end
  
  def slot_info
    result = Hash.new
    details = info_command "slot info\r\n"
    details.encode!('UTF-8')
    details.each do |detail|
      item = detail.split(': ')
      if item.length == 2
        result[item[0].parameterize(separator: '_').to_sym] = item[1]
      end
    end
    result  
  end
  
  def info
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
  
  def simple_command(command)
    messages = [command.chomp]
    messages += connect
    if @status == 'Good'
      @socket.puts command
      messages << read_message
      messages += info
      messages << close
    end
    messages << @status
  end
  
  def info_command(command)
    connect
    if @status == 'Good'
      @socket.puts command
      messages = read_messages
      close
    else
      messages = []
    end
    messages
  end
    
  
end
