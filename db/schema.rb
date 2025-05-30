# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_26_193856) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "conta_bancarias", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "numero_conta"
    t.string "agencia"
    t.decimal "saldo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["numero_conta"], name: "index_conta_bancarias_on_numero_conta", unique: true
    t.index ["user_id"], name: "index_conta_bancarias_on_user_id"
  end

  create_table "transacaos", force: :cascade do |t|
    t.bigint "conta_origem_id", null: false
    t.bigint "conta_destino_id", null: false
    t.decimal "valor"
    t.string "descricao"
    t.datetime "data_hora"
    t.boolean "agendada"
    t.datetime "executar_em"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conta_destino_id"], name: "index_transacaos_on_conta_destino_id"
    t.index ["conta_origem_id"], name: "index_transacaos_on_conta_origem_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "cpf"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "conta_bancarias", "users"
  add_foreign_key "transacaos", "conta_bancarias", column: "conta_destino_id"
  add_foreign_key "transacaos", "conta_bancarias", column: "conta_origem_id"
end
