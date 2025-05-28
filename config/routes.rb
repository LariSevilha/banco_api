Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :api do
    namespace :v1 do
      post 'users', to: 'users#create'
      get 'users', to: 'users#index'
      post 'auth/login', to: 'authentication#login'
      
      get 'conta/saldo', to: 'contas#saldo'
      post 'transferencias', to: 'transferencias#create'
      post 'transferencias/agendada', to: 'transferencias#schedule'
      post 'transferencias/pix', to: 'transferencias#pix' 
      get 'extrato', to: 'transacoes#index'
      post 'transferencias/deposito', to: 'transferencias#deposit'
    end
  end
end