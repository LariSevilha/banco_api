FactoryBot.define do
  factory :conta_bancarias do
    user { nil }
    numero_conta { "MyString" }
    agencia { "MyString" }
    saldo { "9.99" }
  end
end
