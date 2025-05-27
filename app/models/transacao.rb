class Transacao < ApplicationRecord
  belongs_to :conta_origem 
  belongs_to :conta_destino

  validates :valor, presence: true, numericality: { greater_than: 0 }
  validates :descricao, presence: true
  validates :data_hora, presence: true
end
