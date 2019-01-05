Rails.application.routes.draw do
  resources :beds
  resources :students
  resources :teachers
  resources :managers
  resources :rooms
  resources :floors
  resources :houses
  resources :classrooms
  resources :grades
  resources :departments
  resources :colleges
  resources :menu_items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
