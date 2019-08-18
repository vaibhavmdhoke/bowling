class RemoveUnwantedColumnFromFrame < ActiveRecord::Migration[5.0]
  def change
    remove_column :frames, :roll, :fallen_pins, :temp_frame_score
  end
end
