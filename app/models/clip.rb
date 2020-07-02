class Clip < ApplicationRecord
  belongs_to :machine
  
  
  def self.split_line(text_line)
    text_line.split()
  end
  
end
