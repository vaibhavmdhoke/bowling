class FramesController < ApplicationController
  before_action :set_frame, only: [:show, :update, :destroy]

  # GET /frames
  def index
    @frames = Frame.all.order(:id)

    render json: @frames
  end

  # GET /frames/1
  def show
    render json: @frame
  end

  # POST /frames
  def create
    check_for_frame
    @frame = Frame.new(frame_params) if @frame.nil?
    if @frame.save
      render json: @frame, status: :created, location: @frame
    else
      render json: @frame.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /frames/1
  def update
    if @frame.update(frame_params)
      render json: @frame
    else
      render json: @frame.errors, status: :unprocessable_entity
    end
  end

  # DELETE /frames/1
  def destroy
    @frame.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_frame
    @frame = Frame.find(params[:id])
  end

  def check_for_frame
    @frame = Frame.find_by(player_id: frame_params[:player_id], frame_number: frame_params[:frame_number])
    set_values_for_found_frame if @frame.present?
  end

  def set_values_for_found_frame
    @frame.fallen_pins_roll_1 = frame_params[:fallen_pins_roll_1] if frame_params[:fallen_pins_roll_1].present?
    @frame.fallen_pins_roll_2 = frame_params[:fallen_pins_roll_2] if frame_params[:fallen_pins_roll_2].present?
    @frame.fallen_pins_roll_3 = frame_params[:fallen_pins_roll_3] if frame_params[:fallen_pins_roll_3].present?
  end

  # Only allow a trusted parameter "white list" through.
  def frame_params
    params.require(:frame).permit(:frame_number, :player_id,
                                  :fallen_pins_roll_1, :fallen_pins_roll_2,
                                  :fallen_pins_roll_3)
  end
end
