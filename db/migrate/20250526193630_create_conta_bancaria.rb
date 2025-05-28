class CreateContaBancarias < ActiveRecord::Migration[6.1]
  def change
    create_table :conta_bancarias do |t|
      t.string :numero_conta
      t.string :agencia
      t.decimal :saldo, precision: 10, scale: 2, default: 0.0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

# eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3NDg1NDQ1MzV9.zQKW612LF0R1JILdUFg_WYXbgmEGfIHyEaRUAWshcW8

