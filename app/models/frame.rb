class Frame < ApplicationRecord
  belongs_to :player

  before_save :set_frame_state
  after_save :calculate_frame_score

  validates :frame_number, presence: true

  attr_accessor :fallen_pins_roll_1, :fallen_pins_roll_2, :fallen_pins_roll_3

  def set_frame_state
    set_fallen_pins
    self.state = 'strike' if fallen_pins_roll_1 == 10
    self.state = 'spare' if detect_spare
  end

  def set_fallen_pins
    self.rolls['fallen_pins_roll_1'] = fallen_pins_roll_1 if fallen_pins_roll_1.present?
    self.rolls['fallen_pins_roll_2'] = fallen_pins_roll_2 if fallen_pins_roll_2.present?
    self.rolls['fallen_pins_roll_3'] = fallen_pins_roll_3 if fallen_pins_roll_3.present?
  end

  def calculate_frame_score
    all_frames = Frame.where(player_id: player_id)
    frames_without_points = all_frames.where(frame_score: nil)

    frames_without_points.each do |frame|
      calculate_points(frame, all_frames)
    end
  end

  def calculate_points(frame, all_frames)
    calculate_points_for_last_frame(frame) if frame.frame_number.eql?(10)
    return if frame.frame_number.eql?(10)

    case frame.state
    when 'strike'
      calculate_points_for_strike(frame, all_frames)
    when 'spare'
      calculate_point_for_spare(frame, all_frames)
    else
      calculate_point_for_frame(frame) if frame.rolls['fallen_pins_roll_2'].present?
    end
  end

  def calculate_points_for_strike(frame, all_frames)
    subsequent_frames = all_frames.where(frame_number: [frame.frame_number + 1, frame.frame_number + 2])
                                  .order(:frame_number)
    return if skip_calculation?(subsequent_frames)

    rolls = nil
    subsequent_frames.each { |i| rolls = i.rolls.values.compact.flatten }
    frame.update_column(:frame_score, 10 + rolls[0..1].inject(:+))
  end

  def calculate_point_for_spare(frame, all_frames)
    subsequent_frames = all_frames.where(frame_number: [frame.frame_number + 1])
    return if subsequent_frames.empty?

    frame.update_column(:frame_score, 10 + subsequent_frames.first.rolls['fallen_pins_roll_1'].to_i)
  end

  def calculate_point_for_frame(frame)
    frame.update_column(:frame_score, frame.rolls['fallen_pins_roll_1'].to_i + frame.rolls['fallen_pins_roll_2'].to_i)
  end

  def skip_calculation?(subsequent_frames)
    first_successive_roll = subsequent_frames&.first
    return true if first_successive_roll.nil? || detect_for_two_successive_rolls(subsequent_frames)
  end

  def calculate_points_for_last_frame(frame)
    values = frame.rolls.values.compact
    return if (frame.state.present? && values.count < 3) ||
              (frame.state.nil? && values.length < 2)

    frame.update_column(:frame_score, values.inject(:+))
    frame.player.calculate_total_score
  end

  def detect_for_two_successive_rolls(subsequent_frames)
    subsequent_frames.pluck(:rolls).map { |i| i.values.compact }.flatten.length < 2
  end

  def detect_spare
    state.nil? && (rolls['fallen_pins_roll_1'].to_i + rolls['fallen_pins_roll_2'].to_i).eql?(10)
  end

end
