class CreateTransacaos < ActiveRecord::Migration[7.0]
  def change
    create_table :transacaos do |t|
      t.references :conta_origem, null: false, foreign_key: { to_table: :conta_bancarias }
      t.references :conta_destino, null: false, foreign_key: { to_table: :conta_bancarias }
      t.decimal :valor, null: false
      t.string :descricao, null: false
      t.datetime :data_hora, null: false
      t.boolean :agendada, default: false
      t.timestamps
    end
  end
end