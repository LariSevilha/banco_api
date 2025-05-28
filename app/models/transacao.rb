class Transacao < ApplicationRecord
  self.table_name = "transacaos"
  belongs_to :conta_origem, class_name: 'ContaBancaria', foreign_key: 'conta_origem_id'
  belongs_to :conta_destino, class_name: 'ContaBancaria', foreign_key: 'conta_destino_id'
  validates :valor, presence: true, numericality: { greater_than: 0 }
  validates :descricao, presence: true
  validates :data_hora, presence: true
  scope :between_dates, -> (start_date, end_date) { where(data_hora: start_date..end_date) if start_date.present? && end_date.present? }
  scope :min_value, -> (min_val) { where("valor >= ?", min_val) if min_val.present? }
  scope :sent_by_account, -> (account_id) { where(conta_origem_id: account_id) }
  scope :received_by_account, -> (account_id) { where(conta_destino_id: account_id) }
end