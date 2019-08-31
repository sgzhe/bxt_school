Rails.application.routes.draw do
  resources :holidays
  resources :doors
  resources :floors
  resources :menu_accesses
  resources :video_recorders
  resources :incomings
  resources :trackers
  resources :accommodations
  resources :accesses
  resources :webcams
  resources :gates
  resources :gate_logs
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
  resources :sessions
  resources :refreshs
  resources :faces
  resources :import_students
  resources :import_avatars
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
