class CreateClips < ActiveRecord::Migration[6.0]
  def change
    create_table :clips do |t|
      t.integer :slot
      t.integer :number
      t.string :name
      t.string :filename
      t.string :timecode
      t.string :duration
      t.references :machine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
