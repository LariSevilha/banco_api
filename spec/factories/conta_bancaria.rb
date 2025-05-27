FactoryBot.define do
  factory :conta_bancarium do
    user { nil }
    numero_conta { "MyString" }
    agencia { "MyString" }
    saldo { "9.99" }
  end
end
