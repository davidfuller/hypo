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
    rescue Errno::EHOSTUNREACH
      @status = 'Un-reachable'
      message = ['Machine not reachable']
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

  def slot_select(slot)
    detail = standard_command "slot select: slot id:" + slot.to_s
    detail == '200 ok'
  end

  def clip_select(number)
    detail = standard_command "goto: clip id:" + number.to_s
    if detail == '200 ok'
      detail = standard_command "goto: clip: 1" 
      detail == '200 ok'
    else
      false
    end
  end
  
  def slot_info
    details = info_command "slot info\r\n"
    details_to_hash details  
  end
  
  def transport_info
    details = info_command "transport info\r\n"
    details_to_hash details
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
      lines << line.chomp.encode!('UTF-8')
    end
    lines
  end
  
  def read_message
    @socket.gets.chomp.encode!('UTF-8')
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
  
  def details_to_hash(details)
    result = Hash.new
    details.each do |detail|
      item = detail.split(': ')
      if item.length == 2
        result[item[0].parameterize(separator: '_').to_sym] = item[1]
      end
    end
    result
  end

  def standard_command(command)
    connect
    if @status == 'Good'
      @socket.puts command
      message = read_message
      close
    else
      messages = 'Not connected'
    end
    message
  end
    
  
end
