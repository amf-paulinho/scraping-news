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

ActiveRecord::Schema.define(version: 2021_05_12_070602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "head_lines", force: :cascade do |t|
    t.string "source", null: false
    t.string "content_id", null: false
    t.string "title", null: false
    t.string "excerpt"
    t.string "link", null: false
    t.string "image"
    t.datetime "publish_date"
    t.datetime "update_date"
    t.datetime "scrape_date", null: false
    t.index ["content_id"], name: "unique_index_content_id", unique: true
  end

end
