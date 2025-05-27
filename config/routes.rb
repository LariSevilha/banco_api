Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'users', to: 'users#create'
      post 'auth/login', to: 'authentication#login'
      get 'conta/saldo', to: 'contas#saldo'
      post 'transferencias', to: 'transferencias#create'
      post 'transferencias/agendada', to: 'transferencias#schedule'
      get 'extrato', to: 'transacoes#index'
    end
  end
end
