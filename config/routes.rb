Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :faces
    end
  end
  namespace :api do
    namespace :v1 do
      resources :incomings
    end
  end
  namespace :api do
    namespace :v1 do
      resources :students
    end
  end
  namespace :api do
    namespace :v1 do
      resources :trackers
    end
  end
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
