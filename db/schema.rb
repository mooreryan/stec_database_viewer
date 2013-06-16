# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "carcasses", :id => false, :force => true do |t|
    t.string "carcass_plant_id", :limit => 8, :null => false
    t.string "hide_lab_id",      :limit => 8, :null => false
    t.string "carcass_lab_id",   :limit => 8, :null => false
  end

  create_table "crews", :id => false, :force => true do |t|
    t.integer "crew_id",   :limit => 2, :null => false
    t.integer "person_id", :limit => 2, :null => false
  end

  create_table "fecal_samples", :id => false, :force => true do |t|
    t.date   "sample_date",              :null => false
    t.string "pen_id",      :limit => 8, :null => false
    t.string "fecal_id",    :limit => 8, :null => false
  end

  create_table "hide_carcass_samples", :id => false, :force => true do |t|
    t.date   "sample_date",                   :null => false
    t.string "lot_id",           :limit => 8
    t.string "carcass_plant_id", :limit => 8, :null => false
    t.string "pen_id",           :limit => 8, :null => false
  end

  create_table "people", :id => false, :force => true do |t|
    t.integer "person_id", :limit => 2,  :null => false
    t.string  "name",      :limit => 25, :null => false
  end

  create_table "samples", :id => false, :force => true do |t|
    t.string  "sample_id",         :limit => 8,  :null => false
    t.string  "sample_type",       :limit => 25, :null => false
    t.integer "cryobox_num",       :limit => 2,  :null => false
    t.integer "cryobox_location",  :limit => 2,  :null => false
    t.string  "barcode_id",        :limit => 20
    t.string  "processing_status", :limit => 25, :null => false
    t.string  "serotype",          :limit => 10
    t.string  "path_to_sequence"
  end

  create_table "sampling_info", :id => false, :force => true do |t|
    t.date    "sample_date",                :null => false
    t.string  "pen_id",       :limit => 8,  :null => false
    t.integer "head_per_pen", :limit => 2
    t.integer "crew_id",      :limit => 2,  :null => false
    t.text    "observations"
    t.string  "hides_n",      :limit => 20
    t.string  "carcass_n",    :limit => 20
    t.string  "feces_n",      :limit => 20
  end

end
