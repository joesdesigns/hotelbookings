class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

    def calculate_time_to_clean
      #cleaners is the number of indivituals doing the cleaning
      #1 hour per room plus 30 minutes per person in the room
      total_time_to_clean = 0
      find_dirty_rooms.each do |room|
        total_time_to_clean += TIME_TO_CLEAN_ONE_ROOM + (room.guests.to_i * TIME_TO_CLEAN_ONE_GUEST) 
      end
      total_time_to_clean / CLEANING_STAFF_SIZE
    end

    def calculate_cost(room_id,params)
      guests = params[:guests]
      bags = params[:bags]
    end

    def guest_has_bags?(params)
      params[:bags] && params[:bags].to_i > 0
    end

end
