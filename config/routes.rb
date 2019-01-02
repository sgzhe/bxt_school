Rails.application.routes.draw do
  resources :classrooms
  resources :grades
  resources :departments
  resources :colleges
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
