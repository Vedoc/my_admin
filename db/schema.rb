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

ActiveRecord::Schema[7.1].define(version: 2025_06_20_092956) do
  create_schema "tiger"
  create_schema "tiger_data"
  create_schema "topology"

  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_tiger_geocoder"
  enable_extension "postgis_topology"

  create_table "accounts", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "email", default: "", null: false
    t.boolean "employee", default: false, null: false
    t.integer "accountable_id"
    t.string "accountable_type"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts"
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "unconfirmed_email"
    t.index ["accountable_type", "accountable_id"], name: "index_accounts_on_accountable_type_and_accountable_id"
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_accounts_on_uid_and_provider", unique: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addr", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.bigint "tlid"
    t.string "fromhn", limit: 12
    t.string "tohn", limit: 12
    t.string "side", limit: 1
    t.string "zip", limit: 5
    t.string "plus4", limit: 4
    t.string "fromtyp", limit: 1
    t.string "totyp", limit: 1
    t.integer "fromarmid"
    t.integer "toarmid"
    t.string "arid", limit: 22
    t.string "mtfcc", limit: 5
    t.string "statefp", limit: 2
    t.index ["tlid", "statefp"], name: "idx_tiger_addr_tlid_statefp"
    t.index ["zip"], name: "idx_tiger_addr_zip"
  end

  create_table "addrfeat", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.bigint "tlid"
    t.string "statefp", limit: 2, null: false
    t.string "aridl", limit: 22
    t.string "aridr", limit: 22
    t.string "linearid", limit: 22
    t.string "fullname", limit: 100
    t.string "lfromhn", limit: 12
    t.string "ltohn", limit: 12
    t.string "rfromhn", limit: 12
    t.string "rtohn", limit: 12
    t.string "zipl", limit: 5
    t.string "zipr", limit: 5
    t.string "edge_mtfcc", limit: 5
    t.string "parityl", limit: 1
    t.string "parityr", limit: 1
    t.string "plus4l", limit: 4
    t.string "plus4r", limit: 4
    t.string "lfromtyp", limit: 1
    t.string "ltotyp", limit: 1
    t.string "rfromtyp", limit: 1
    t.string "rtotyp", limit: 1
    t.string "offsetl", limit: 1
    t.string "offsetr", limit: 1
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.index ["the_geom"], name: "idx_addrfeat_geom_gist", using: :gist
    t.index ["tlid"], name: "idx_addrfeat_tlid"
    t.index ["zipl"], name: "idx_addrfeat_zipl"
    t.index ["zipr"], name: "idx_addrfeat_zipr"
    t.check_constraint "geometrytype(the_geom) = 'LINESTRING'::text OR the_geom IS NULL", name: "enforce_geotype_the_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_the_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_the_geom"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "admin_users_roles", id: false, force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "role_id"
    t.index ["admin_user_id", "role_id"], name: "index_admin_users_roles_on_admin_user_id_and_role_id"
    t.index ["admin_user_id"], name: "index_admin_users_roles_on_admin_user_id"
    t.index ["role_id"], name: "index_admin_users_roles_on_role_id"
  end

  create_table "app_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bg", primary_key: "bg_id", id: { type: :string, limit: 12 }, comment: "block groups", force: :cascade do |t|
    t.serial "gid", null: false
    t.string "statefp", limit: 2
    t.string "countyfp", limit: 3
    t.string "tractce", limit: 6
    t.string "blkgrpce", limit: 1
    t.string "namelsad", limit: 13
    t.string "mtfcc", limit: 5
    t.string "funcstat", limit: 1
    t.float "aland"
    t.float "awater"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_geom"
  end

  create_table "car_categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_car_categories_on_name", unique: true
  end

  create_table "car_makes", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "car_category_id"
    t.index ["car_category_id"], name: "index_car_makes_on_car_category_id"
    t.index ["name", "car_category_id"], name: "index_car_makes_on_name_and_car_category_id", unique: true
  end

  create_table "car_models", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "car_make_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_make_id"], name: "index_car_models_on_car_make_id"
    t.index ["name", "car_make_id"], name: "index_car_models_on_name_and_car_make_id", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", default: ""
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "address"
    t.string "phone", default: ""
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "card_token"
    t.boolean "approved", default: true, null: false
    t.index ["location"], name: "index_clients_on_location", using: :gist
  end

  create_table "county", primary_key: "cntyidfp", id: { type: :string, limit: 5 }, force: :cascade do |t|
    t.serial "gid", null: false
    t.string "statefp", limit: 2
    t.string "countyfp", limit: 3
    t.string "countyns", limit: 8
    t.string "name", limit: 100
    t.string "namelsad", limit: 100
    t.string "lsad", limit: 2
    t.string "classfp", limit: 2
    t.string "mtfcc", limit: 5
    t.string "csafp", limit: 3
    t.string "cbsafp", limit: 5
    t.string "metdivfp", limit: 5
    t.string "funcstat", limit: 1
    t.bigint "aland"
    t.float "awater"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.index ["countyfp"], name: "idx_tiger_county"
    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_geom"
    t.unique_constraint ["gid"], name: "uidx_county_gid"
  end

  create_table "county_lookup", primary_key: ["st_code", "co_code"], force: :cascade do |t|
    t.integer "st_code", null: false
    t.string "state", limit: 2
    t.integer "co_code", null: false
    t.string "name", limit: 90
    t.index "soundex((name)::text)", name: "county_lookup_name_idx"
    t.index ["state"], name: "county_lookup_state_idx"
  end

  create_table "countysub_lookup", primary_key: ["st_code", "co_code", "cs_code"], force: :cascade do |t|
    t.integer "st_code", null: false
    t.string "state", limit: 2
    t.integer "co_code", null: false
    t.string "county", limit: 90
    t.integer "cs_code", null: false
    t.string "name", limit: 90
    t.index "soundex((name)::text)", name: "countysub_lookup_name_idx"
    t.index ["state"], name: "countysub_lookup_state_idx"
  end

  create_table "cousub", primary_key: "cosbidfp", id: { type: :string, limit: 10 }, force: :cascade do |t|
    t.serial "gid", null: false
    t.string "statefp", limit: 2
    t.string "countyfp", limit: 3
    t.string "cousubfp", limit: 5
    t.string "cousubns", limit: 8
    t.string "name", limit: 100
    t.string "namelsad", limit: 100
    t.string "lsad", limit: 2
    t.string "classfp", limit: 2
    t.string "mtfcc", limit: 5
    t.string "cnectafp", limit: 3
    t.string "nectafp", limit: 5
    t.string "nctadvfp", limit: 5
    t.string "funcstat", limit: 1
    t.decimal "aland", precision: 14
    t.decimal "awater", precision: 14
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.index ["the_geom"], name: "tige_cousub_the_geom_gist", using: :gist
    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_the_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_the_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_the_geom"
    t.unique_constraint ["gid"], name: "uidx_cousub_gid"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_token"
    t.string "device_id", null: false
    t.integer "platform", default: 0, null: false
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["account_id"], name: "index_devices_on_account_id"
    t.index ["device_id", "platform", "account_id"], name: "index_devices_on_device_id_and_platform_and_account_id", unique: true
    t.index ["device_token", "device_id"], name: "index_devices_on_device_token_and_device_id", unique: true, where: "(device_token IS NOT NULL)"
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "direction_lookup", primary_key: "name", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "abbrev", limit: 3
    t.index ["abbrev"], name: "direction_lookup_abbrev_idx"
  end

  create_table "edges", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.string "statefp", limit: 2
    t.string "countyfp", limit: 3
    t.bigint "tlid"
    t.decimal "tfidl", precision: 10
    t.decimal "tfidr", precision: 10
    t.string "mtfcc", limit: 5
    t.string "fullname", limit: 100
    t.string "smid", limit: 22
    t.string "lfromadd", limit: 12
    t.string "ltoadd", limit: 12
    t.string "rfromadd", limit: 12
    t.string "rtoadd", limit: 12
    t.string "zipl", limit: 5
    t.string "zipr", limit: 5
    t.string "featcat", limit: 1
    t.string "hydroflg", limit: 1
    t.string "railflg", limit: 1
    t.string "roadflg", limit: 1
    t.string "olfflg", limit: 1
    t.string "passflg", limit: 1
    t.string "divroad", limit: 1
    t.string "exttyp", limit: 1
    t.string "ttyp", limit: 1
    t.string "deckedroad", limit: 1
    t.string "artpath", limit: 1
    t.string "persist", limit: 1
    t.string "gcseflg", limit: 1
    t.string "offsetl", limit: 1
    t.string "offsetr", limit: 1
    t.decimal "tnidf", precision: 10
    t.decimal "tnidt", precision: 10
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.index ["countyfp"], name: "idx_tiger_edges_countyfp"
    t.index ["the_geom"], name: "idx_tiger_edges_the_geom_gist", using: :gist
    t.index ["tlid"], name: "idx_edges_tlid"
    t.check_constraint "geometrytype(the_geom) = 'MULTILINESTRING'::text OR the_geom IS NULL", name: "enforce_geotype_the_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_the_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_the_geom"
  end

  create_table "faces", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.decimal "tfid", precision: 10
    t.string "statefp00", limit: 2
    t.string "countyfp00", limit: 3
    t.string "tractce00", limit: 6
    t.string "blkgrpce00", limit: 1
    t.string "blockce00", limit: 4
    t.string "cousubfp00", limit: 5
    t.string "submcdfp00", limit: 5
    t.string "conctyfp00", limit: 5
    t.string "placefp00", limit: 5
    t.string "aiannhfp00", limit: 5
    t.string "aiannhce00", limit: 4
    t.string "comptyp00", limit: 1
    t.string "trsubfp00", limit: 5
    t.string "trsubce00", limit: 3
    t.string "anrcfp00", limit: 5
    t.string "elsdlea00", limit: 5
    t.string "scsdlea00", limit: 5
    t.string "unsdlea00", limit: 5
    t.string "uace00", limit: 5
    t.string "cd108fp", limit: 2
    t.string "sldust00", limit: 3
    t.string "sldlst00", limit: 3
    t.string "vtdst00", limit: 6
    t.string "zcta5ce00", limit: 5
    t.string "tazce00", limit: 6
    t.string "ugace00", limit: 5
    t.string "puma5ce00", limit: 5
    t.string "statefp", limit: 2
    t.string "countyfp", limit: 3
    t.string "tractce", limit: 6
    t.string "blkgrpce", limit: 1
    t.string "blockce", limit: 4
    t.string "cousubfp", limit: 5
    t.string "submcdfp", limit: 5
    t.string "conctyfp", limit: 5
    t.string "placefp", limit: 5
    t.string "aiannhfp", limit: 5
    t.string "aiannhce", limit: 4
    t.string "comptyp", limit: 1
    t.string "trsubfp", limit: 5
    t.string "trsubce", limit: 3
    t.string "anrcfp", limit: 5
    t.string "ttractce", limit: 6
    t.string "tblkgpce", limit: 1
    t.string "elsdlea", limit: 5
    t.string "scsdlea", limit: 5
    t.string "unsdlea", limit: 5
    t.string "uace", limit: 5
    t.string "cd111fp", limit: 2
    t.string "sldust", limit: 3
    t.string "sldlst", limit: 3
    t.string "vtdst", limit: 6
    t.string "zcta5ce", limit: 5
    t.string "tazce", limit: 6
    t.string "ugace", limit: 5
    t.string "puma5ce", limit: 5
    t.string "csafp", limit: 3
    t.string "cbsafp", limit: 5
    t.string "metdivfp", limit: 5
    t.string "cnectafp", limit: 3
    t.string "nectafp", limit: 5
    t.string "nctadvfp", limit: 5
    t.string "lwflag", limit: 1
    t.string "offset", limit: 1
    t.float "atotal"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.string "tractce20", limit: 6
    t.string "blkgrpce20", limit: 1
    t.string "blockce20", limit: 4
    t.string "countyfp20", limit: 3
    t.string "statefp20", limit: 2
    t.index ["countyfp"], name: "idx_tiger_faces_countyfp"
    t.index ["tfid"], name: "idx_tiger_faces_tfid"
    t.index ["the_geom"], name: "tiger_faces_the_geom_gist", using: :gist
    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_the_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_the_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_the_geom"
  end

  create_table "featnames", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.bigint "tlid"
    t.string "fullname", limit: 100
    t.string "name", limit: 100
    t.string "predirabrv", limit: 15
    t.string "pretypabrv", limit: 50
    t.string "prequalabr", limit: 15
    t.string "sufdirabrv", limit: 15
    t.string "suftypabrv", limit: 50
    t.string "sufqualabr", limit: 15
    t.string "predir", limit: 2
    t.string "pretyp", limit: 3
    t.string "prequal", limit: 2
    t.string "sufdir", limit: 2
    t.string "suftyp", limit: 3
    t.string "sufqual", limit: 2
    t.string "linearid", limit: 22
    t.string "mtfcc", limit: 5
    t.string "paflag", limit: 1
    t.string "statefp", limit: 2
    t.index "lower((name)::text)", name: "idx_tiger_featnames_lname"
    t.index "soundex((name)::text)", name: "idx_tiger_featnames_snd_name"
    t.index ["tlid", "statefp"], name: "idx_tiger_featnames_tlid_statefp"
  end

  create_table "geocode_settings", primary_key: "name", id: :text, force: :cascade do |t|
    t.text "setting"
    t.text "unit"
    t.text "category"
    t.text "short_desc"
  end

  create_table "geocode_settings_default", primary_key: "name", id: :text, force: :cascade do |t|
    t.text "setting"
    t.text "unit"
    t.text "category"
    t.text "short_desc"
  end

  create_table "loader_lookuptables", primary_key: "lookup_name", id: { type: :text, comment: "This is the table name to inherit from and suffix of resulting output table -- how the table will be named --  edges here would mean -- ma_edges , pa_edges etc. except in the case of national tables. national level tables have no prefix" }, force: :cascade do |t|
    t.integer "process_order", default: 1000, null: false
    t.text "table_name", comment: "suffix of the tables to load e.g.  edges would load all tables like *edges.dbf(shp)  -- so tl_2010_42129_edges.dbf .  "
    t.boolean "single_mode", default: true, null: false
    t.boolean "load", default: true, null: false, comment: "Whether or not to load the table.  For states and zcta5 (you may just want to download states10, zcta510 nationwide file manually) load your own into a single table that inherits from tiger.states, tiger.zcta5.  You'll get improved performance for some geocoding cases."
    t.boolean "level_county", default: false, null: false
    t.boolean "level_state", default: false, null: false
    t.boolean "level_nation", default: false, null: false, comment: "These are tables that contain all data for the whole US so there is just a single file"
    t.text "post_load_process"
    t.boolean "single_geom_mode", default: false
    t.string "insert_mode", limit: 1, default: "c", null: false
    t.text "pre_load_process"
    t.text "columns_exclude", comment: "List of columns to exclude as an array. This is excluded from both input table and output table and rest of columns remaining are assumed to be in same order in both tables. gid, geoid,cpi,suffix1ce are excluded if no columns are specified.", array: true
    t.text "website_root_override", comment: "Path to use for wget instead of that specified in year table.  Needed currently for zcta where they release that only for 2000 and 2010"
  end

  create_table "loader_platform", primary_key: "os", id: { type: :string, limit: 50 }, force: :cascade do |t|
    t.text "declare_sect"
    t.text "pgbin"
    t.text "wget"
    t.text "unzip_command"
    t.text "psql"
    t.text "path_sep"
    t.text "loader"
    t.text "environ_set_command"
    t.text "county_process_command"
  end

  create_table "loader_variables", primary_key: "tiger_year", id: { type: :string, limit: 4 }, force: :cascade do |t|
    t.text "website_root"
    t.text "staging_fold"
    t.text "data_schema"
    t.text "staging_schema"
  end

  create_table "model_years", force: :cascade do |t|
    t.integer "year", null: false
    t.bigint "car_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_model_id"], name: "index_model_years_on_car_model_id"
    t.index ["year", "car_model_id"], name: "index_model_years_on_year_and_car_model_id", unique: true
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "service_request_id", null: false
    t.bigint "shop_id", null: false
    t.decimal "budget", precision: 10, scale: 2, null: false
    t.string "description"
    t.boolean "accepted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "paid", precision: 10, scale: 2, default: "0.0"
    t.index ["service_request_id", "shop_id"], name: "index_offers_on_service_request_id_and_shop_id", unique: true
    t.index ["service_request_id"], name: "index_offers_on_service_request_id"
    t.index ["shop_id"], name: "index_offers_on_shop_id"
  end

  create_table "pagc_gaz", id: :serial, force: :cascade do |t|
    t.integer "seq"
    t.text "word"
    t.text "stdword"
    t.integer "token"
    t.boolean "is_custom", default: true, null: false
  end

  create_table "pagc_lex", id: :serial, force: :cascade do |t|
    t.integer "seq"
    t.text "word"
    t.text "stdword"
    t.integer "token"
    t.boolean "is_custom", default: true, null: false
  end

  create_table "pagc_rules", id: :serial, force: :cascade do |t|
    t.text "rule"
    t.boolean "is_custom", default: true
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "service_request_id", null: false
    t.string "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_request_id"], name: "index_photos_on_service_request_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "data"
    t.string "imageable_type", null: false
    t.bigint "imageable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable"
  end

  create_table "place", primary_key: "plcidfp", id: { type: :string, limit: 7 }, force: :cascade do |t|
    t.serial "gid", null: false
    t.string "statefp", limit: 2
    t.string "placefp", limit: 5
    t.string "placens", limit: 8
    t.string "name", limit: 100
    t.string "namelsad", limit: 100
    t.string "lsad", limit: 2
    t.string "classfp", limit: 2
    t.string "cpi", limit: 1
    t.string "pcicbsa", limit: 1
    t.string "pcinecta", limit: 1
    t.string "mtfcc", limit: 5
    t.string "funcstat", limit: 1
    t.bigint "aland"
    t.bigint "awater"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.index ["the_geom"], name: "tiger_place_the_geom_gist", using: :gist
    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_the_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_the_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_the_geom"
    t.unique_constraint ["gid"], name: "uidx_tiger_place_gid"
  end

  create_table "place_lookup", primary_key: ["st_code", "pl_code"], force: :cascade do |t|
    t.integer "st_code", null: false
    t.string "state", limit: 2
    t.integer "pl_code", null: false
    t.string "name", limit: 90
    t.index "soundex((name)::text)", name: "place_lookup_name_idx"
    t.index ["state"], name: "place_lookup_state_idx"
  end

  create_table "promo_codes", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.string "email", null: false
    t.string "code_token"
    t.datetime "activated_at"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_promo_codes_on_shop_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.string "car_needs", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score", default: 0, null: false
    t.bigint "offer_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_ratings_on_client_id"
    t.index ["offer_id"], name: "index_ratings_on_offer_id", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "secondary_unit_lookup", primary_key: "name", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "abbrev", limit: 5
    t.index ["abbrev"], name: "secondary_unit_lookup_abbrev_idx"
  end

  create_table "service_requests", force: :cascade do |t|
    t.text "summary", default: "", null: false
    t.string "title", default: "", null: false
    t.decimal "estimated_budget", precision: 10, scale: 2
    t.integer "category", default: 0, null: false
    t.bigint "vehicle_id"
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.string "address", default: "", null: false
    t.boolean "evacuation", default: false, null: false
    t.boolean "repair_parts", default: false, null: false
    t.datetime "schedule_service"
    t.string "vin"
    t.integer "radius"
    t.integer "mileage"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location"], name: "index_service_requests_on_location", using: :gist
    t.index ["vehicle_id"], name: "index_service_requests_on_vehicle_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "owner_name", default: "", null: false
    t.string "hours_of_operation", default: "", null: false
    t.integer "techs_per_shift", default: 0, null: false
    t.boolean "certified", default: false
    t.boolean "lounge_area", default: false, null: false
    t.boolean "supervisor_permanently", default: false, null: false
    t.text "languages", default: [], array: true
    t.boolean "tow_track", default: false
    t.boolean "complimentary_inspection", default: false, null: false
    t.boolean "vehicle_diesel", default: false
    t.boolean "vehicle_electric", default: false
    t.boolean "vehicle_warranties", default: false, null: false
    t.integer "categories", default: [], null: false, array: true
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.string "address", default: "", null: false
    t.string "phone", default: "", null: false
    t.boolean "approved", default: true, null: false
    t.string "avatar"
    t.text "additional_info"
    t.decimal "average_rating", precision: 3, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "facebook"
    t.string "instagram"
    t.string "hiring_email"
    t.string "stripe_token"
    t.bigint "user_id"
    t.index ["approved"], name: "index_shops_on_approved"
    t.index ["categories"], name: "index_shops_on_categories", using: :gin
    t.index ["location"], name: "index_shops_on_location", using: :gist
    t.index ["name"], name: "index_shops_on_name", unique: true
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "state", primary_key: "statefp", id: { type: :string, limit: 2 }, force: :cascade do |t|
    t.serial "gid", null: false
    t.string "region", limit: 2
    t.string "division", limit: 2
    t.string "statens", limit: 8
    t.string "stusps", limit: 2, null: false
    t.string "name", limit: 100
    t.string "lsad", limit: 2
    t.string "mtfcc", limit: 5
    t.string "funcstat", limit: 1
    t.bigint "aland"
    t.bigint "awater"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.index ["the_geom"], name: "idx_tiger_state_the_geom_gist", using: :gist
    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_the_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_the_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_the_geom"
    t.unique_constraint ["gid"], name: "uidx_tiger_state_gid"
    t.unique_constraint ["stusps"], name: "uidx_tiger_state_stusps"
  end

  create_table "state_lookup", primary_key: "st_code", id: :integer, default: nil, force: :cascade do |t|
    t.string "name", limit: 40
    t.string "abbrev", limit: 3
    t.string "statefp", limit: 2

    t.unique_constraint ["abbrev"], name: "state_lookup_abbrev_key"
    t.unique_constraint ["name"], name: "state_lookup_name_key"
    t.unique_constraint ["statefp"], name: "state_lookup_statefp_key"
  end

  create_table "street_type_lookup", primary_key: "name", id: { type: :string, limit: 50 }, force: :cascade do |t|
    t.string "abbrev", limit: 50
    t.boolean "is_hw", default: false, null: false
    t.index ["abbrev"], name: "street_type_lookup_abbrev_idx"
  end

  create_table "tabblock", primary_key: "tabblock_id", id: { type: :string, limit: 16 }, force: :cascade do |t|
    t.serial "gid", null: false
    t.string "statefp", limit: 2
    t.string "countyfp", limit: 3
    t.string "tractce", limit: 6
    t.string "blockce", limit: 4
    t.string "name", limit: 20
    t.string "mtfcc", limit: 5
    t.string "ur", limit: 1
    t.string "uace", limit: 5
    t.string "funcstat", limit: 1
    t.float "aland"
    t.float "awater"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_geom"
  end

  create_table "tabblock20", primary_key: "geoid", id: { type: :string, limit: 15 }, force: :cascade do |t|
    t.string "statefp", limit: 2
    t.string "countyfp", limit: 3
    t.string "tractce", limit: 6
    t.string "blockce", limit: 4
    t.string "name", limit: 10
    t.string "mtfcc", limit: 5
    t.string "ur", limit: 1
    t.string "uace", limit: 5
    t.string "uatype", limit: 1
    t.string "funcstat", limit: 1
    t.float "aland"
    t.float "awater"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
    t.float "housing"
    t.float "pop"
  end

  create_table "tract", primary_key: "tract_id", id: { type: :string, limit: 11 }, force: :cascade do |t|
    t.serial "gid", null: false
    t.string "statefp", limit: 2
    t.string "countyfp", limit: 3
    t.string "tractce", limit: 6
    t.string "name", limit: 7
    t.string "namelsad", limit: 20
    t.string "mtfcc", limit: 5
    t.string "funcstat", limit: 1
    t.float "aland"
    t.float "awater"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}
    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_geom"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "make", default: "", null: false
    t.string "model", default: "", null: false
    t.integer "year", default: 0, null: false
    t.string "category", default: "", null: false
    t.bigint "client_id"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_vehicles_on_client_id"
  end

  create_table "videos", force: :cascade do |t|
    t.bigint "service_request_id", null: false
    t.string "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_request_id"], name: "index_videos_on_service_request_id"
  end

  create_table "zcta5", primary_key: ["zcta5ce", "statefp"], force: :cascade do |t|
    t.serial "gid", null: false
    t.string "statefp", limit: 2, null: false
    t.string "zcta5ce", limit: 5, null: false
    t.string "classfp", limit: 2
    t.string "mtfcc", limit: 5
    t.string "funcstat", limit: 1
    t.float "aland"
    t.float "awater"
    t.string "intptlat", limit: 11
    t.string "intptlon", limit: 12
    t.string "partflg", limit: 1
    t.geometry "the_geom", limit: {:srid=>0, :type=>"geometry"}

    t.check_constraint "geometrytype(the_geom) = 'MULTIPOLYGON'::text OR the_geom IS NULL", name: "enforce_geotype_the_geom"
    t.check_constraint "st_ndims(the_geom) = 2", name: "enforce_dims_the_geom"
    t.check_constraint "st_srid(the_geom) = 4269", name: "enforce_srid_the_geom"
    t.unique_constraint ["gid"], name: "uidx_tiger_zcta5_gid"
  end

  create_table "zip_lookup", primary_key: "zip", id: :integer, default: nil, force: :cascade do |t|
    t.integer "st_code"
    t.string "state", limit: 2
    t.integer "co_code"
    t.string "county", limit: 90
    t.integer "cs_code"
    t.string "cousub", limit: 90
    t.integer "pl_code"
    t.string "place", limit: 90
    t.integer "cnt"
  end

  create_table "zip_lookup_all", id: false, force: :cascade do |t|
    t.integer "zip"
    t.integer "st_code"
    t.string "state", limit: 2
    t.integer "co_code"
    t.string "county", limit: 90
    t.integer "cs_code"
    t.string "cousub", limit: 90
    t.integer "pl_code"
    t.string "place", limit: 90
    t.integer "cnt"
  end

  create_table "zip_lookup_base", primary_key: "zip", id: { type: :string, limit: 5 }, force: :cascade do |t|
    t.string "state", limit: 40
    t.string "county", limit: 90
    t.string "city", limit: 90
    t.string "statefp", limit: 2
  end

  create_table "zip_state", primary_key: ["zip", "stusps"], force: :cascade do |t|
    t.string "zip", limit: 5, null: false
    t.string "stusps", limit: 2, null: false
    t.string "statefp", limit: 2
  end

  create_table "zip_state_loc", primary_key: ["zip", "stusps", "place"], force: :cascade do |t|
    t.string "zip", limit: 5, null: false
    t.string "stusps", limit: 2, null: false
    t.string "statefp", limit: 2
    t.string "place", limit: 100, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "car_makes", "car_categories", on_delete: :cascade
  add_foreign_key "car_models", "car_makes", on_delete: :cascade
  add_foreign_key "devices", "accounts", on_delete: :cascade
  add_foreign_key "devices", "users"
  add_foreign_key "model_years", "car_models", on_delete: :cascade
  add_foreign_key "photos", "service_requests"
  add_foreign_key "ratings", "clients", on_delete: :nullify
  add_foreign_key "ratings", "offers", on_delete: :cascade
  add_foreign_key "service_requests", "vehicles", on_delete: :cascade
  add_foreign_key "shops", "users"
  add_foreign_key "vehicles", "clients", on_delete: :cascade
  add_foreign_key "videos", "service_requests"
end
