class AddRollsToFrames < ActiveRecord::Migration[5.0]
  def change
    add_column :frames, :rolls, :jsonb, null: false, default: {fallen_pins_roll_1: nil, fallen_pins_roll_2:nil}
  end
end
