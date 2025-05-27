class User < ApplicationRecord
    has_secure_password
  
    has_one :conta_bancaria, dependent: :destroy
  
    validates :nome, presence: true
    validates :email, presence: true, uniqueness: true
    validates :cpf, presence: true, uniqueness: true, cpf: true
  end
  