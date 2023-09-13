Rails.application.routes.draw do
  root :to => "web/boards#show"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Sidekiq::Web => '/admin/sidekiq'

  scope module: :web do
    resource :board, only: :show
    resource :session, only: [:new, :create, :destroy]
    resources :developers, only: [:new, :create]
    resource :recover_password, only: [:new, :create, :edit, :update]
  end

  namespace :admin do
    resources :users
  end

  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
      resources :tasks do
        member do
          put 'attach_image'
          put 'remove_image'
        end
      end
      resources :users, only: [:index, :show]
    end
  end
end
