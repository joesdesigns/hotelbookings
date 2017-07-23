class RoomsController < ApplicationController
  def book
    # Find any available rooms based on the number of guests and number of bags
    render json: {status: :ok, guests: params[:guests], bags: params[:bags], rooms: find_available_rooms(room_params)}
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
      #lets put guests with bags only in rooms with storage capabilities
      #and guests without bags in rooms without storage
      if params[:bags] && params[:bags].to_i > 0
        #with bags
        @rooms = Room.joins(:storages).where('status=0').where('max_storage - storage >= :storage', :storage => params[:bags].to_i).where('max_guests - guests >= :guests', :guests => params[:guests].to_i)
      else
        #without bags
        @rooms = Room.left_outer_joins(:storages).where('status=0').where(storages: {id: nil}).where('max_guests - guests >= :guests', :guests => params[:guests].to_i)
      end
      #TODO add additional options
      # 1) put a guest without bags in a room with storage
      # 2) split up guests into any available bed (creepy)
    end
end
