Rails.application.routes.draw do

  devise_for :customers, path: 'auth', controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}
  devise_for :agents, path: 'auth', controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}
  devise_for :admins, path: 'auth', controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}

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
        resources :tickets, only: [:index, :show, :update] do
          put :assign
          put :solve
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
