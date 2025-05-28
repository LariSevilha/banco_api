class CreateContaBancaria < ActiveRecord::Migration[8.0]
  def change
    create_table :conta_bancarias do |t|
      t.references :user, null: false, foreign_key: true
      t.string :numero_conta
      t.string :agencia
      t.decimal :saldo

      t.timestamps
    end
    add_index :conta_bancarias, :numero_conta, unique: true
  end
end
