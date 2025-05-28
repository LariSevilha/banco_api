FactoryBot.define do
    factory :account do
      user  
      sequence(:numero_conta) { |n| "000#{n}" }  
      saldo { 1000.00 }  
    end
  end