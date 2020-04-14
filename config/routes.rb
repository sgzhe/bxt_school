Rails.application.routes.draw do
  namespace :client do
    resources :dicts
    resources :incomings
    resources :trackers
    resources :latecomers
    resources :students
    resources :houses
    resources :faces
    resources :packages
    resources :cards
    resources :floors
    resources :colleges
  end
  resources :packages
  resources :shifts
  resources :homings
  resources :holidays
  resources :doors
  resources :floors
  resources :menu_accesses
  resources :video_recorders
  resources :incomings
  resources :trackers
  resources :accommodations
  resources :face_accesses
  resources :card_accesses
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
  resources :cards
  resources :import_students
  resources :import_avatars
  resources :exchanges
  mount ActionCable.server => "/cable"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
