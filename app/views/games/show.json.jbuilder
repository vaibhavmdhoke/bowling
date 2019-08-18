json.extract! @game, :id, :name, :created_at, :updated_at
json.players @game.players do |player|
  json.player_id player.id
  json.name player.name
  json.total_score player.total_score
  json.frames player.frames.order(:frame_number), :frame_number, :rolls, :frame_score, :state 
end
json.url game_url(@game, format: :json)
