class RoomsController < ApplicationController
  def book
  end

  def list
    #TODO - Status shows up as a number we should create a enum or status list to use
    #       status 0 = available, 1 = occupied, 2 = needs cleaning
    #TODO - The storage for rooms with no storage shows up null we shold make it pretty
    render json: { status: :ok, guests: params[:guests], bags: params[:bags], rooms: all_rooms_with_status}
  end

  def list_available
  end

  def cleaning_schedule
  end

  private

    def all_rooms_with_status
      @list = Room.left_outer_joins(:storages).select("rooms.*").select("storages.max_storage, storages.storage")
    end

end
