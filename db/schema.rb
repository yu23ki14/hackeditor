# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_19_145558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "memo_relations", force: :cascade do |t|
    t.bigint "memo_id"
    t.bigint "sub_memo_id"
    t.text "semantic"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["memo_id", "sub_memo_id"], name: "index_memo_relations_on_memo_id_and_sub_memo_id", unique: true
    t.index ["memo_id"], name: "index_memo_relations_on_memo_id"
    t.index ["sub_memo_id"], name: "index_memo_relations_on_sub_memo_id"
  end

  create_table "memos", force: :cascade do |t|
    t.string "title"
    t.text "main"
    t.text "reference"
    t.text "reference_other_details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "memo_relations", "memos"
  add_foreign_key "memo_relations", "memos", column: "sub_memo_id"
end
