class AddVolumeToClips < ActiveRecord::Migration[6.0]
  def change
    add_column :clips, :volume, :string
  end
end
