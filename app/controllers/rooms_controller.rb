class RoomsController < ApplicationController
  def book
    # Find any available rooms based on the number of guests and number of bags
    render json: {status: :ok, guests: params[:guests], bags: params[:bags], rooms: find_available_rooms(room_params)}
  end

  def list
    #TODO - Status shows up as a number we should create a enum or status list to use
    #       status 0 = available, 1 = occupied, 2 = needs cleaning
    #TODO - The storage for rooms with no storage shows up null we shold make it pretty
    render json: { status: :ok, guests: params[:guests], bags: params[:bags], rooms: all_rooms_with_status}
  end

  def list_available
    render json: { status: :ok, guests: params[:guests], bags: params[:bags], rooms: find_available_rooms(room_params)}
  end

  def cleaning_schedule
    render json: { status: :ok, time_to_clean: calculate_time_to_clean(1)}
  end

  private

    def calculate_time_to_clean(cleaners)
      #cleaners is the number of indivituals doing the cleaning
      #1 hour per room plus 30 minutes per person in the room
      total_time_to_clean = 0
      find_dirty_rooms.each do |room|
        total_time_to_clean += 60 + (room.guests.to_i * 30) 
      end
      total_time_to_clean / cleaners
    end

    def find_dirty_rooms
      @list = Room.left_outer_joins(:storages).select("rooms.*").select("storages.max_storage, storages.storage").where('status=2')
    end

    def all_rooms_with_status
      @list = Room.left_outer_joins(:storages).select("rooms.*").select("storages.max_storage, storages.storage")
    end

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
