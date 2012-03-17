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

ActiveRecord::Schema.define(:version => 20111231145823) do

  create_table "bookmark_stat_has_manifestations", :force => true do |t|
    t.integer  "bookmark_stat_id", :null => false
    t.integer  "manifestation_id", :null => false
    t.integer  "bookmarks_count"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "bookmark_stat_has_manifestations", ["bookmark_stat_id"], :name => "index_bookmark_stat_has_manifestations_on_bookmark_stat_id"
  add_index "bookmark_stat_has_manifestations", ["manifestation_id"], :name => "index_bookmark_stat_has_manifestations_on_manifestation_id"

  create_table "bookmark_stats", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.text     "note"
    t.string   "state"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "manifestation_id"
    t.text     "title"
    t.string   "url"
    t.text     "note"
    t.boolean  "shared"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "bookmarks", ["manifestation_id"], :name => "index_bookmarks_on_manifestation_id"
  add_index "bookmarks", ["url"], :name => "index_bookmarks_on_url"
  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "carrier_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "checkout_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "checkout_types", ["name"], :name => "index_checkout_types_on_name"

  create_table "circulation_statuses", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "content_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "exemplifies", :force => true do |t|
    t.integer  "manifestation_id", :null => false
    t.integer  "item_id",          :null => false
    t.string   "type"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "exemplifies", ["item_id"], :name => "index_exemplifies_on_item_id", :unique => true
  add_index "exemplifies", ["manifestation_id"], :name => "index_exemplifies_on_manifestation_id"
  add_index "exemplifies", ["type"], :name => "index_exemplifies_on_type"

  create_table "item_has_use_restrictions", :force => true do |t|
    t.integer  "item_id",            :null => false
    t.integer  "use_restriction_id", :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "item_has_use_restrictions", ["item_id"], :name => "index_item_has_use_restrictions_on_item_id"
  add_index "item_has_use_restrictions", ["use_restriction_id"], :name => "index_item_has_use_restrictions_on_use_restriction_id"

  create_table "items", :force => true do |t|
    t.string   "call_number"
    t.string   "item_identifier"
    t.integer  "circulation_status_id",       :default => 5,     :null => false
    t.integer  "checkout_type_id",            :default => 1,     :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.datetime "deleted_at"
    t.integer  "shelf_id",                    :default => 1,     :null => false
    t.integer  "basket_id"
    t.boolean  "include_supplements",         :default => false, :null => false
    t.integer  "checkouts_count",             :default => 0,     :null => false
    t.integer  "owns_count",                  :default => 0,     :null => false
    t.integer  "resource_has_subjects_count", :default => 0,     :null => false
    t.text     "note"
    t.string   "url"
    t.integer  "price"
    t.integer  "lock_version",                :default => 0,     :null => false
    t.integer  "required_role_id",            :default => 1,     :null => false
    t.string   "state"
    t.integer  "required_score",              :default => 0,     :null => false
  end

  add_index "items", ["checkout_type_id"], :name => "index_items_on_checkout_type_id"
  add_index "items", ["circulation_status_id"], :name => "index_items_on_circulation_status_id"
  add_index "items", ["item_identifier"], :name => "index_items_on_item_identifier"
  add_index "items", ["required_role_id"], :name => "index_items_on_required_role_id"
  add_index "items", ["shelf_id"], :name => "index_items_on_shelf_id"

  create_table "languages", :force => true do |t|
    t.string  "name",         :null => false
    t.string  "native_name"
    t.text    "display_name"
    t.string  "iso_639_1"
    t.string  "iso_639_2"
    t.string  "iso_639_3"
    t.text    "note"
    t.integer "position"
  end

  add_index "languages", ["iso_639_1"], :name => "index_languages_on_iso_639_1"
  add_index "languages", ["iso_639_2"], :name => "index_languages_on_iso_639_2"
  add_index "languages", ["iso_639_3"], :name => "index_languages_on_iso_639_3"
  add_index "languages", ["name"], :name => "index_languages_on_name", :unique => true

  create_table "libraries", :force => true do |t|
    t.integer  "patron_id"
    t.string   "patron_type"
    t.string   "name",                                   :null => false
    t.text     "display_name"
    t.string   "short_display_name",                     :null => false
    t.string   "zip_code"
    t.text     "street"
    t.text     "locality"
    t.text     "region"
    t.string   "telephone_number_1"
    t.string   "telephone_number_2"
    t.string   "fax_number"
    t.text     "note"
    t.integer  "call_number_rows",      :default => 1,   :null => false
    t.string   "call_number_delimiter", :default => "|", :null => false
    t.integer  "library_group_id",      :default => 1,   :null => false
    t.integer  "users_count",           :default => 0,   :null => false
    t.integer  "position"
    t.integer  "country_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.datetime "deleted_at"
  end

  add_index "libraries", ["library_group_id"], :name => "index_libraries_on_library_group_id"
  add_index "libraries", ["name"], :name => "index_libraries_on_name", :unique => true
  add_index "libraries", ["patron_id"], :name => "index_libraries_on_patron_id", :unique => true

  create_table "library_groups", :force => true do |t|
    t.string   "name",                                                              :null => false
    t.text     "display_name"
    t.string   "short_name",                                                        :null => false
    t.string   "email"
    t.text     "my_networks"
    t.text     "login_banner"
    t.text     "note"
    t.integer  "valid_period_for_new_user",   :default => 365,                      :null => false
    t.boolean  "post_to_union_catalog",       :default => false,                    :null => false
    t.integer  "country_id"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.text     "admin_networks"
    t.boolean  "allow_bookmark_external_url", :default => false,                    :null => false
    t.integer  "position"
    t.string   "url",                         :default => "http://localhost:3000/"
  end

  add_index "library_groups", ["short_name"], :name => "index_library_groups_on_short_name"

  create_table "manifestations", :force => true do |t|
    t.text     "original_title",                              :null => false
    t.text     "title_alternative"
    t.text     "title_transcription"
    t.string   "classification_number"
    t.string   "manifestation_identifier"
    t.datetime "date_of_publication"
    t.datetime "copyright_date"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.datetime "deleted_at"
    t.string   "access_address"
    t.integer  "language_id",              :default => 1,     :null => false
    t.integer  "carrier_type_id",          :default => 1,     :null => false
    t.integer  "extent_id",                :default => 1,     :null => false
    t.integer  "start_page"
    t.integer  "end_page"
    t.decimal  "height"
    t.decimal  "width"
    t.decimal  "depth"
    t.string   "isbn"
    t.string   "isbn10"
    t.string   "wrong_isbn"
    t.string   "nbn"
    t.string   "lccn"
    t.string   "oclc_number"
    t.string   "issn"
    t.integer  "price"
    t.text     "fulltext"
    t.string   "volume_number_string"
    t.string   "issue_number_string"
    t.string   "serial_number_string"
    t.integer  "edition"
    t.text     "note"
    t.integer  "produces_count",           :default => 0,     :null => false
    t.integer  "exemplifies_count",        :default => 0,     :null => false
    t.integer  "embodies_count",           :default => 0,     :null => false
    t.integer  "work_has_subjects_count",  :default => 0,     :null => false
    t.boolean  "repository_content",       :default => false, :null => false
    t.integer  "lock_version",             :default => 0,     :null => false
    t.integer  "required_role_id",         :default => 1,     :null => false
    t.string   "state"
    t.integer  "required_score",           :default => 0,     :null => false
    t.integer  "frequency_id",             :default => 1,     :null => false
    t.boolean  "subscription_master",      :default => false, :null => false
    t.string   "pub_date"
    t.string   "edition_string"
    t.integer  "volume_number"
    t.integer  "issue_number"
    t.integer  "serial_number"
  end

  add_index "manifestations", ["access_address"], :name => "index_manifestations_on_access_address"
  add_index "manifestations", ["carrier_type_id"], :name => "index_manifestations_on_carrier_type_id"
  add_index "manifestations", ["frequency_id"], :name => "index_manifestations_on_frequency_id"
  add_index "manifestations", ["isbn"], :name => "index_manifestations_on_isbn"
  add_index "manifestations", ["issn"], :name => "index_manifestations_on_issn"
  add_index "manifestations", ["lccn"], :name => "index_manifestations_on_lccn"
  add_index "manifestations", ["manifestation_identifier"], :name => "index_manifestations_on_manifestation_identifier"
  add_index "manifestations", ["nbn"], :name => "index_manifestations_on_nbn"
  add_index "manifestations", ["oclc_number"], :name => "index_manifestations_on_oclc_number"
  add_index "manifestations", ["required_role_id"], :name => "index_manifestations_on_required_role_id"
  add_index "manifestations", ["updated_at"], :name => "index_manifestations_on_updated_at"

  create_table "patron_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "patrons", :force => true do |t|
    t.integer  "user_id"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "first_name"
    t.string   "last_name_transcription"
    t.string   "middle_name_transcription"
    t.string   "first_name_transcription"
    t.string   "corporate_name"
    t.string   "corporate_name_transcription"
    t.string   "full_name"
    t.text     "full_name_transcription"
    t.text     "full_name_alternative"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.datetime "deleted_at"
    t.string   "zip_code_1"
    t.string   "zip_code_2"
    t.text     "address_1"
    t.text     "address_2"
    t.text     "address_1_note"
    t.text     "address_2_note"
    t.string   "telephone_number_1"
    t.string   "telephone_number_2"
    t.string   "fax_number_1"
    t.string   "fax_number_2"
    t.text     "other_designation"
    t.text     "place"
    t.string   "postal_code"
    t.text     "street"
    t.text     "locality"
    t.text     "region"
    t.datetime "date_of_birth"
    t.datetime "date_of_death"
    t.integer  "language_id",                  :default => 1, :null => false
    t.integer  "country_id",                   :default => 1, :null => false
    t.integer  "patron_type_id",               :default => 1, :null => false
    t.integer  "lock_version",                 :default => 0, :null => false
    t.text     "note"
    t.integer  "creates_count",                :default => 0, :null => false
    t.integer  "realizes_count",               :default => 0, :null => false
    t.integer  "produces_count",               :default => 0, :null => false
    t.integer  "owns_count",                   :default => 0, :null => false
    t.integer  "required_role_id",             :default => 1, :null => false
    t.integer  "required_score",               :default => 0, :null => false
    t.string   "state"
    t.text     "email"
    t.text     "url"
  end

  add_index "patrons", ["country_id"], :name => "index_patrons_on_country_id"
  add_index "patrons", ["full_name"], :name => "index_patrons_on_full_name"
  add_index "patrons", ["language_id"], :name => "index_patrons_on_language_id"
  add_index "patrons", ["required_role_id"], :name => "index_patrons_on_required_role_id"
  add_index "patrons", ["user_id"], :name => "index_patrons_on_user_id", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "series_has_manifestations", :force => true do |t|
    t.integer  "series_statement_id"
    t.integer  "manifestation_id"
    t.integer  "position"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "series_has_manifestations", ["manifestation_id"], :name => "index_series_has_manifestations_on_manifestation_id"
  add_index "series_has_manifestations", ["series_statement_id"], :name => "index_series_has_manifestations_on_series_statement_id"

  create_table "series_statements", :force => true do |t|
    t.text     "original_title"
    t.text     "numbering"
    t.text     "title_subseries"
    t.text     "numbering_subseries"
    t.integer  "position"
    t.text     "title_transcription"
    t.text     "title_alternative"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "series_statement_identifier"
    t.string   "issn"
    t.boolean  "periodical"
    t.integer  "root_manifestation_id"
    t.text     "note"
  end

  add_index "series_statements", ["root_manifestation_id"], :name => "index_series_statements_on_manifestation_id"
  add_index "series_statements", ["series_statement_identifier"], :name => "index_series_statements_on_series_statement_identifier"

  create_table "shelves", :force => true do |t|
    t.string   "name",                        :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "library_id",   :default => 1, :null => false
    t.integer  "items_count",  :default => 0, :null => false
    t.integer  "position"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.datetime "deleted_at"
  end

  add_index "shelves", ["library_id"], :name => "index_shelves_on_library_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "name_transcription"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "use_restrictions", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_has_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "user_group_id"
    t.integer  "required_role_id"
    t.string   "username"
    t.text     "note"
    t.string   "locale"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "share_bookmarks"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
