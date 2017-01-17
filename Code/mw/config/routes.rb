Rails.application.routes.draw do

  namespace :ng do
    namespace :v1 do
      namespace :auth do
        devise_for :customers, controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}
        devise_for :agents, controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}
        devise_for :admins, controllers: {sessions: 'ng/v1/auth/sessions', registrations: 'ng/v1/auth/registrations'}
      end
      namespace :admin do
        resources :agents
        resources :tickets, except: [:create, :edit, :new]
        resources :customers, only: [:index, :destroy]
      end
      namespace :agent do
        resources :tickets, only: [:index]
      end
      namespace :customer do
        resources :tickets, only: [:index, :show, :destroy]
      end
    end
  end
end
