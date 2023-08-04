Rails.application.routes.draw do
  devise_for :users

  root "worklogs#index"

  resources :invitations, only: %i[new create]
  resources :worklogs, only: %i[index]
end
