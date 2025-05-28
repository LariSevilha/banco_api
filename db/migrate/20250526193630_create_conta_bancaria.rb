class CreateContaBancarias < ActiveRecord::Migration[7.0]
  def change
    create_table :conta_bancarias do |t|
      t.references :user, null: false, foreign_key: true
      t.string :numero_conta, null: false
      t.string :agencia, null: false
      t.decimal :saldo, null: false, default: 0.0
      t.timestamps
    end
    add_index :conta_bancarias, :numero_conta, unique: true
  end
end