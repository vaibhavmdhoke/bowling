class Player < ApplicationRecord
  belongs_to :game
  has_many :frames

  def calculate_total_score
    total_score = self.frames.pluck(:frame_score).inject(:+)
    self.update_column(:total_score, total_score)
  end
end
