Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  root "worklogs#index"

  resources :invitations, only: %i[new create]
  resources :worklogs, only: %i[index create update]
end
