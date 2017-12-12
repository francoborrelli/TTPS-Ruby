# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171212203604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year"], name: "index_courses_on_year", unique: true
  end

  create_table "examinations", force: :cascade do |t|
    t.bigint "course_id"
    t.string "title", null: false
    t.datetime "date", null: false
    t.float "min_score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_examinations_on_course_id"
  end

  create_table "scores", force: :cascade do |t|
    t.float "score", null: false
    t.bigint "examination_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["examination_id"], name: "index_scores_on_examination_id"
    t.index ["student_id"], name: "index_scores_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "surname", null: false
    t.string "name", null: false
    t.string "s_number", null: false
    t.string "email", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dni"
    t.index ["course_id"], name: "index_students_on_course_id"
    t.index ["dni"], name: "index_students_on_dni"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "examinations", "courses"
  add_foreign_key "scores", "examinations"
  add_foreign_key "scores", "students"
  add_foreign_key "students", "courses"
end
