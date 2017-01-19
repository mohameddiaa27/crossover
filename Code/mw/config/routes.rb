Rails.application.routes.draw do

  devise_for :customers, controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}
  devise_for :agents, controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}
  devise_for :admins, controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}

  namespace :ng do
    namespace :v1 do
      namespace :admin do
        resources :agents
        resources :customers, only: [:index, :destroy]
        resources :tickets, only: [:index, :create, :destroy, :show] do
          resources :comments, only: [:index, :destroy]
        end
      end
      namespace :agent do
        resources :tickets, only: [:index, :show] do
          post :assign
          resources :comments, only: [:index, :destroy]
        end
      end
      namespace :customer do
        resources :tickets, only: [:index, :show, :destroy, :create] do
          resources :comments, only: [:index, :destroy]
        end
      end
    end
  end
end
