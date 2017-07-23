Rails.application.routes.draw do
  get 'rooms/book'

  get 'rooms/list'

  get 'rooms/list_available'

  get 'rooms/cleaning_schedule'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
