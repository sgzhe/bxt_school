Rails.application.routes.draw do
  resources :trackers
  resources :accommodations
  resources :accesses
  resources :webcams
  resources :gates
  resources :latecomers
  resources :attendances
  resources :permissions
  resources :groups
  resources :roles
  resources :dicts
  resources :orgs
  resources :students
  resources :teachers
  resources :managers
  resources :rooms
  resources :houses
  resources :classrooms
  resources :departments
  resources :colleges
  resources :menu_items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
