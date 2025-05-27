class CreateTransacaos < ActiveRecord::Migration[8.0]
  def change
    create_table :transacaos do |t|
      t.references :conta_origem, null: false, foreign_key: { to_table: :conta_bancarias }
      t.references :conta_destino, null: false, foreign_key: { to_table: :conta_bancarias }
      t.decimal :valor
      t.string :descricao
      t.datetime :data_hora
      t.boolean :agendada
      t.datetime :executar_em

      t.timestamps
    end
  end
end
