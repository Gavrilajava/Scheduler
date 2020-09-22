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

ActiveRecord::Schema.define(version: 2020_09_22_135401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.integer "production_id"
    t.integer "workcenter_id"
    t.integer "sequence"
    t.datetime "start"
    t.datetime "end"
    t.string "info"
    t.integer "previous_quantity"
    t.string "inks"
    t.string "number_ups"
    t.string "tools"
    t.string "operation"
    t.integer "produced"
    t.integer "split_quantity"
    t.string "outers"
    t.string "varnish_plate"
    t.integer "quantity"
    t.string "varnish"
    t.integer "part"
    t.datetime "fixed_date"
    t.integer "target_speed"
    t.integer "performance"
    t.integer "setup"
    t.string "possible_workcenters"
    t.integer "operation_number"
    t.string "dynamics_job"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "productions", force: :cascade do |t|
    t.string "order"
    t.string "cad"
    t.date "next_call_off"
    t.string "info"
    t.string "combination"
    t.string "inline_coding"
    t.string "variant"
    t.string "gluing_points"
    t.string "item"
    t.string "board"
    t.string "route"
    t.string "customer"
    t.string "name"
    t.integer "next_call_off_quantity"
    t.string "status"
    t.integer "qty_per_pallet"
    t.date "confirmed_date"
    t.date "required_date"
    t.string "order_type"
    t.string "sales_order_line"
    t.string "sales_order"
    t.date "possible_date"
    t.date "order_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.integer "user_id"
    t.string "time"
    t.string "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workcenters", force: :cascade do |t|
    t.string "group"
    t.string "name"
    t.string "code"
    t.text "description"
    t.float "average_downtime"
    t.integer "frozen_period"
    t.integer "minimal_setup"
    t.string "setup_reduction_type"
    t.integer "average_setup"
    t.integer "average_speed"
    t.integer "max_deviation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_date"
  end

end
