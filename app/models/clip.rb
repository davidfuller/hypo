class Clip < ApplicationRecord
  belongs_to :machine
  
  
  def self.split_line(text_line)
    text_line.split()
  end
  
  def self.new_clip_from_list(slot, list, machine_id)
    clip = Clip.new
    
    clip.slot = slot[:slot_id]
    clip.number = list[:number]
    clip.name = name_from_filename(list[:filename])
    clip.filename = list[:filename]
    clip.timecode = list[:timecode]
    clip.duration = list[:duration]
    clip.machine_id = machine_id
    clip.volume = slot[:volume_name]
    
    clip.save
    
  end
  
  private
  def self.name_from_filename(filename)
    if filename.include?('.mov')
      result = filename.gsub('.mov', '').lowercase
    else
      result = filename.lowercase
    end
    result
  end
    
end
