class RoomsController < ApplicationController
  def book
    room_options = find_available_rooms(room_params)
    if room_options.count > 0
      room = room_options.first 
      book_room(room.id,room_params)
      cost = calculate_cost(room.id,room_params)
      render json: {status: :ok, guests: params[:guests], bags: params[:bags], rooms: room, cost: cost}
    else
      render json: {status: 'No room found', guests: params[:guests], bags: params[:bags]}
    end
  end

  def list
    #TODO - Status shows up as a number we should create a enum or status list to use
    #       status 0 = available, 1 = occupied, 2 = needs cleaning
    #TODO - The storage for rooms with no storage shows up null we shold make it pretty
    render json: {status: :ok, guests: params[:guests], bags: params[:bags], rooms: all_rooms_with_status}
  end

  def list_available
    render json: {status: :ok, guests: params[:guests], bags: params[:bags], rooms: find_available_rooms(room_params)}
  end

  def cleaning_schedule
    render json: {status: :ok, time_to_clean: calculate_time_to_clean}
  end

  private

    def find_dirty_rooms
      @list = Room.left_outer_joins(:storages).select("rooms.*").select("storages.max_storage, storages.storage").where('status = :room_status', :room_status => DIRTY)
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
      if guest_has_bags?(room_params)
        @rooms = Room.joins(:storages).where('status=0').where('max_storage - storage >= :storage', :storage => params[:bags].to_i).where('max_guests - guests >= :guests', :guests => params[:guests].to_i)
      else
        #without bags
        @rooms = Room.left_outer_joins(:storages).where('status=0').where(storages: {id: nil}).where('max_guests - guests >= :guests', :guests => params[:guests].to_i)
      end
      #TODO add additional options
      # 1) put a guest without bags in a room with storage
      # 2) split up guests into any available bed (creepy)
    end

    def book_room(room_id,params)
      #update the room record 
      @guests_room = Room.find_by_id(room_id)
      @guests_room.guests += params[:guests].to_i
      cost = 
      @guests_room.save
      #update the storage record if there are bags
      if guest_has_bags?(room_params)
        @storage = Storages.find_by_room_id(room_id)
        @storage.storage += params[:bags].to_i
        @storage.save
      end
    end
end
