class ContaBancaria < ApplicationRecord
  self.table_name = "conta_bancarias"
  belongs_to :user
  has_many :transacoes_origem, class_name: 'Transacao', foreign_key: 'conta_origem_id'
  has_many :transacoes_destino, class_name: 'Transacao', foreign_key: 'conta_destino_id'

  validates :numero_conta, presence: true, uniqueness: true
  validates :agencia, presence: true
  validates :saldo, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
