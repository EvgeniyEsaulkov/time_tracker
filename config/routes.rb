Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users

  root "worklogs#index"

  resources :invitations, only: %i[new create]
  resources :worklogs, only: %i[index]
end
