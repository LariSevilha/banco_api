require 'rails_helper'

RSpec.describe User, type: :model do
  it 'é válido com atributos válidos' do
    user = User.new(
      nome: 'João Silva',
      email: 'joao@example.com',
      cpf: '12345678909',
      password: 'senha123',
      password_confirmation: 'senha123'
    )
    expect(user).to be_valid
  end

  it 'não é válido sem nome' do
    user = User.new(nome: nil)
    user.valid?
    expect(user.errors[:nome]).to include("can't be blank")
  end
end
