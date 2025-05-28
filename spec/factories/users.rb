FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    nome { 'Usuário Teste' }
    cpf { Faker::CPF.numeric }  

    after(:create) do |user|
      create(:account, user: user) 
    end
  end
end

