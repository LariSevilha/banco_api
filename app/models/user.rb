class User < ApplicationRecord
  has_secure_password
  has_one :conta_bancaria, dependent: :destroy
  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true, cpf: true
  after_create :create_associated_bank_account
  def create_associated_bank_account
    account_number = Time.now.strftime("%Y%m%d%H%M%S") + SecureRandom.random_number(10000).to_s.rjust(4, '0')
    ContaBancaria.create!(user: self, numero_conta: account_number, agencia: "0001", saldo: 0.0)
  end
end