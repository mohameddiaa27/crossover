Rails.application.routes.draw do

  devise_for :customers, path: 'auth', controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}
  devise_for :agents, path: 'auth', controllers: {sessions: 'ng/v1/auth/sessions'}
  devise_for :admins, path: 'auth', controllers: {sessions: 'ng/v1/auth/sessions'}

  namespace :ng do
    namespace :v1 do
      namespace :admin do
        resources :agents, only: [:index, :create]
        resources :customers, only: [:index, :destroy]
        resources :tickets, only: [:index, :create, :destroy, :show, :update] do
          resources :comments, only: [:index, :destroy, :create]
        end
      end
      namespace :agent do
        resources :tickets, only: [:index, :show, :update] do
          put :assign
          put :solve
          resources :comments, only: [:index, :destroy, :create]
        end
      end
      namespace :customer do
        resources :tickets, only: [:index, :show, :destroy, :create, :update] do
          resources :comments, only: [:index, :destroy, :create]
        end
      end
    end
  end
end
