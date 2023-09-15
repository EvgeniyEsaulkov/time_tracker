Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  root "worklogs#index"

  resources :invitations, only: %i[new create]
  resources :worklogs, only: %i[index update]
end
