class RoomsController < ApplicationController
  def book
    render json: { status: :ok, guests: params[:guests], bags: params[:bags], rooms: find_available_rooms(room_params)}
  end

  def list
  end

  def list_available
  end

  def cleaning_schedule
  end

   private

    def room_params
      params.permit(:guests, :bags)
    end

    def find_available_rooms(params)
      if params[:bags] && params[:bags].to_i > 0
        #with bags
        @rooms = Room.joins(:storages).where('status=0').where('max_storage - storage >= :storage', :storage => params[:bags].to_i).where('max_guests - guests >= :guests', :guests => params[:guests].to_i)
      else
        #without bags
        @rooms = Room.left_outer_joins(:storages).where('status=0').where(storages: {id: nil}).where('max_guests - guests >= :guests', :guests => params[:guests].to_i)
      end
    end
end
