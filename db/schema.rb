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

ActiveRecord::Schema.define(version: 2020_07_02_160410) do

  create_table "clips", force: :cascade do |t|
    t.integer "slot"
    t.integer "number"
    t.string "name"
    t.string "filename"
    t.string "timecode"
    t.string "duration"
    t.integer "machine_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "volume"
    t.index ["machine_id"], name: "index_clips_on_machine_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.integer "port"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "clips", "machines"
end
