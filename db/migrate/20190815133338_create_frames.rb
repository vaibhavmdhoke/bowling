class CreateFrames < ActiveRecord::Migration[5.0]
  def change
    create_table :frames do |t|
      t.integer :frame_number
      t.integer :roll
      t.integer :fallen_pins
      t.integer :frame_score
      t.integer :temp_frame_score
      t.string :state
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
