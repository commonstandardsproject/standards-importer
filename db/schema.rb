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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150708101057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "account_metrics", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                                                                    null: false
    t.string   "account_name",             limit: 255,                                          null: false
    t.string   "account_status",           limit: 25,                                           null: false
    t.string   "account_group",            limit: 255
    t.string   "sis_name",                 limit: 255
    t.json     "entitlements",                                                  default: {},    null: false
    t.string   "product_name",             limit: 255,                                          null: false
    t.boolean  "sis_enabled",                                                   default: false, null: false
    t.boolean  "ldap_enabled",                                                  default: false, null: false
    t.decimal  "balance",                              precision: 12, scale: 2, default: 0.0,   null: false
    t.string   "superuser_emails",                                              default: [],    null: false, array: true
    t.integer  "subscribed_users",                                              default: 0,     null: false
    t.integer  "total_users",                                                   default: 0,     null: false
    t.integer  "active_staff",                                                  default: 0,     null: false
    t.integer  "active_students",                                               default: 0,     null: false
    t.json     "active_students_by_grade",                                      default: {}
    t.integer  "active_schools",                                                default: 0,     null: false
    t.integer  "total_courses",                                                 default: 0,     null: false
    t.integer  "active_courses",                                                default: 0,     null: false
    t.integer  "total_folders",                                                 default: 0,     null: false
    t.integer  "active_folders",                                                default: 0,     null: false
    t.integer  "total_files",                                                   default: 0,     null: false
    t.integer  "total_storage",            limit: 8,                            default: 0,     null: false
    t.integer  "upload_count",                                                  default: 0,     null: false
    t.integer  "download_count",                                                default: 0,     null: false
    t.integer  "submission_count",                                              default: 0,     null: false
    t.integer  "review_count",                                                  default: 0,     null: false
    t.integer  "parent_count",                                                  default: 0,     null: false
    t.integer  "parent_relation_count",                                         default: 0,     null: false
    t.datetime "expires_at",                                                                    null: false
    t.datetime "created_at",                                                                    null: false
  end

  add_index "account_metrics", ["account_id"], name: "index_account_metrics_on_account_id", using: :btree
  add_index "account_metrics", ["account_status"], name: "index_account_metrics_on_account_status", using: :btree
  add_index "account_metrics", ["created_at"], name: "index_account_metrics_on_created_at", using: :btree
  add_index "account_metrics", ["product_name"], name: "index_account_metrics_on_product_name", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["queue"], name: "index_delayed_jobs_on_queue", using: :btree

  create_table "embedded_media_files", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "type",                   limit: 255
    t.string   "file_name",              limit: 255
    t.integer  "file_size"
    t.string   "content_type",           limit: 255
    t.integer  "height"
    t.integer  "width"
    t.string   "mongo_backpack_file_id", limit: 24
    t.string   "mongo_created_by_id",    limit: 24
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.uuid     "account_id"
  end

  add_index "embedded_media_files", ["account_id"], name: "index_embedded_media_files_on_account_id", using: :btree
  add_index "embedded_media_files", ["mongo_backpack_file_id"], name: "index_embedded_media_files_on_mongo_backpack_file_id", using: :btree
  add_index "embedded_media_files", ["mongo_created_by_id"], name: "index_embedded_media_files_on_mongo_created_by_id", using: :btree
  add_index "embedded_media_files", ["type"], name: "index_embedded_media_files_on_type", using: :btree

  create_table "external_calendar_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "external_calendar_id"
    t.string   "external_id",          limit: 255
    t.string   "summary",              limit: 255
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "mongo_assignment_id",  limit: 24
    t.uuid     "assignment_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "external_calendar_events", ["external_calendar_id"], name: "index_external_calendar_events_on_external_calendar_id", using: :btree
  add_index "external_calendar_events", ["external_id"], name: "index_external_calendar_events_on_external_id", using: :btree

  create_table "external_calendar_queue_tasks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "category",                limit: 255
    t.string   "action",                  limit: 255
    t.datetime "locked_at"
    t.string   "locked_by",               limit: 255
    t.string   "mongo_authentication_id", limit: 24
    t.uuid     "authentication_id"
    t.string   "mongo_assignment_id",     limit: 24
    t.uuid     "assignment_id"
    t.string   "mongo_course_id",         limit: 24
    t.uuid     "course_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "external_calendar_queue_tasks", ["created_at"], name: "index_external_calendar_queue_tasks_on_created_at", using: :btree
  add_index "external_calendar_queue_tasks", ["locked_at"], name: "index_external_calendar_queue_tasks_on_locked_at", using: :btree

  create_table "external_calendars", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "external_id",             limit: 255
    t.uuid     "authentication_id"
    t.string   "mongo_authentication_id", limit: 24
    t.string   "summary",                 limit: 255, default: "eBackpack Assignments"
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
  end

  add_index "external_calendars", ["external_id"], name: "index_external_calendars_on_external_id", using: :btree
  add_index "external_calendars", ["mongo_authentication_id"], name: "index_external_calendars_on_mongo_authentication_id", unique: true, using: :btree

  create_table "file_masks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_group_id", limit: 24
    t.string   "mongo_file_id",  limit: 24
    t.boolean  "mask_direction",            default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.datetime "mask_start_at"
    t.datetime "mask_end_at"
    t.string   "mongo_user_ids",            default: [],    null: false, array: true
    t.boolean  "date_direction",            default: false
    t.boolean  "default_hide",              default: false
  end

  add_index "file_masks", ["mongo_file_id"], name: "index_file_masks_on_mongo_file_id", using: :btree
  add_index "file_masks", ["mongo_group_id"], name: "index_file_masks_on_mongo_group_id", using: :btree

  create_table "folder_masks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_group_id",  limit: 24
    t.string   "mongo_folder_id", limit: 24
    t.boolean  "mask_direction",             default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "mask_start_at"
    t.datetime "mask_end_at"
    t.string   "mongo_user_ids",             default: [],    null: false, array: true
    t.boolean  "date_direction",             default: false
    t.boolean  "default_hide",               default: false
  end

  add_index "folder_masks", ["mongo_folder_id"], name: "index_folder_masks_on_mongo_folder_id", using: :btree
  add_index "folder_masks", ["mongo_group_id"], name: "index_folder_masks_on_mongo_group_id", using: :btree

  create_table "jurisdictions", id: false, force: :cascade do |t|
    t.string "id"
    t.string "required"
    t.string "index"
    t.string "title"
    t.string "type"
  end

  add_index "jurisdictions", ["id"], name: "index_jurisdictions_on_id", unique: true, using: :btree

  create_table "logging_account_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
  end

  add_index "logging_account_logs", ["account_id", "created_at"], name: "index_logging_account_logs_on_ai_ca", using: :btree
  add_index "logging_account_logs", ["category_id"], name: "index_logging_account_logs_on_category_id", using: :btree
  add_index "logging_account_logs", ["mongo_id"], name: "index_logging_account_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_account_logs", ["mongo_user_id"], name: "index_logging_account_logs_on_mongo_user_id", using: :btree

  create_table "logging_admin_parent_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.inet     "ip"
    t.string   "mongo_admin_user_id", limit: 24
    t.string   "mongo_parent_id",     limit: 24
    t.json     "change"
  end

  add_index "logging_admin_parent_logs", ["category_id"], name: "index_logging_admin_parent_logs_on_category_id", using: :btree
  add_index "logging_admin_parent_logs", ["mongo_admin_user_id"], name: "index_logging_admin_parent_logs_on_mongo_admin_user_id", using: :btree
  add_index "logging_admin_parent_logs", ["mongo_parent_id"], name: "index_logging_admin_parent_logs_on_mongo_parent_id", using: :btree

  create_table "logging_admin_user_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id"
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.inet     "ip"
    t.string   "mongo_admin_user_id", limit: 24
    t.string   "mongo_user_id",       limit: 24
    t.json     "change"
  end

  add_index "logging_admin_user_logs", ["category_id"], name: "index_logging_admin_user_logs_on_category_id", using: :btree
  add_index "logging_admin_user_logs", ["mongo_admin_user_id"], name: "index_logging_admin_user_logs_on_mongo_admin_user_id", using: :btree
  add_index "logging_admin_user_logs", ["mongo_user_id"], name: "index_logging_admin_user_logs_on_mongo_user_id", using: :btree

  create_table "logging_background_job_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",         limit: 24
    t.uuid     "account_id"
    t.string   "mongo_account_id", limit: 24
    t.string   "job_name",         limit: 255
    t.json     "properties"
    t.datetime "completed_at"
    t.text     "log_text"
    t.boolean  "scheduled",                    default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "logging_background_job_logs", ["created_at", "job_name"], name: "logging_background_job_logs_on_created_job_name_properties", using: :btree
  add_index "logging_background_job_logs", ["mongo_account_id", "updated_at"], name: "logging_background_job_logs_on_mai_updated", using: :btree
  add_index "logging_background_job_logs", ["mongo_id"], name: "index_logging_background_job_logs_on_mongo_id", using: :btree

  create_table "logging_course_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.string   "mongo_target_id",     limit: 24
  end

  add_index "logging_course_logs", ["account_id", "created_at"], name: "index_logging_course_logs_on_ai_ca", using: :btree
  add_index "logging_course_logs", ["category_id"], name: "index_logging_course_logs_on_category_id", using: :btree
  add_index "logging_course_logs", ["mongo_id"], name: "index_logging_course_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_course_logs", ["mongo_target_id"], name: "index_logging_course_logs_on_mongo_target_id", using: :btree
  add_index "logging_course_logs", ["mongo_user_id"], name: "index_logging_course_logs_on_mongo_user_id", using: :btree

  create_table "logging_external_calendar_queue_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "category",                limit: 255
    t.string   "action",                  limit: 255
    t.string   "mongo_authentication_id", limit: 24
    t.uuid     "authentication_id"
    t.string   "mongo_assignment_id",     limit: 255
    t.uuid     "assignment_id"
    t.string   "mongo_course_id",         limit: 255
    t.uuid     "course_id"
    t.uuid     "calendar_id"
    t.uuid     "calendar_event_id"
    t.boolean  "successful",                          default: true
    t.boolean  "retry",                               default: false
    t.string   "error_class",             limit: 255
    t.string   "error_message",           limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.uuid     "task_id"
  end

  add_index "logging_external_calendar_queue_logs", ["created_at"], name: "index_logging_external_calendar_queue_logs_on_created_at", using: :btree

  create_table "logging_file_annotation_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.string   "mongo_target_id",     limit: 24
  end

  add_index "logging_file_annotation_logs", ["account_id", "created_at"], name: "index_logging_file_annotation_logs_on_ai_ca", using: :btree
  add_index "logging_file_annotation_logs", ["category_id"], name: "index_logging_file_annotation_logs_on_category_id", using: :btree
  add_index "logging_file_annotation_logs", ["mongo_id"], name: "index_logging_file_annotation_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_file_annotation_logs", ["mongo_target_id"], name: "index_logging_file_annotation_logs_on_mongo_target_id", using: :btree
  add_index "logging_file_annotation_logs", ["mongo_user_id"], name: "index_logging_file_annotation_logs_on_mongo_user_id", using: :btree

  create_table "logging_file_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",             limit: 24
    t.uuid     "account_id",                      null: false
    t.integer  "category_id",                     null: false
    t.datetime "created_at",                      null: false
    t.string   "mongo_user_id",        limit: 24
    t.string   "mongo_actor_user_id",  limit: 24
    t.inet     "ip"
    t.json     "change"
    t.string   "mongo_file_id",        limit: 24
    t.string   "mongo_version_id",     limit: 24
    t.string   "mongo_group_id",       limit: 24
    t.string   "mongo_parent_id",      limit: 24
    t.string   "mongo_copied_from_id", limit: 24
    t.string   "mongo_old_folder_id",  limit: 24
    t.string   "endpoint_source",      limit: 10
  end

  add_index "logging_file_logs", ["account_id", "created_at"], name: "index_logging_file_logs_on_ai_ca", using: :btree
  add_index "logging_file_logs", ["category_id"], name: "index_logging_file_logs_on_category_id", using: :btree
  add_index "logging_file_logs", ["mongo_file_id"], name: "index_logging_file_logs_on_mongo_file_id", using: :btree
  add_index "logging_file_logs", ["mongo_id"], name: "index_logging_file_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_file_logs", ["mongo_user_id"], name: "index_logging_file_logs_on_mongo_user_id", using: :btree
  add_index "logging_file_logs", ["mongo_version_id"], name: "index_logging_file_logs_on_mongo_version_id", using: :btree

  create_table "logging_file_submission_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id",                      null: false
    t.integer  "category_id",                     null: false
    t.datetime "created_at",                      null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.string   "mongo_target_id",     limit: 24
    t.string   "mongo_folder_id",     limit: 24
    t.string   "mongo_file_id",       limit: 24
    t.string   "name",                limit: 255
    t.string   "endpoint_source",     limit: 10
  end

  add_index "logging_file_submission_logs", ["account_id", "created_at"], name: "index_logging_file_submission_logs_on_ai_ca", using: :btree
  add_index "logging_file_submission_logs", ["category_id"], name: "index_logging_file_submission_logs_on_category_id", using: :btree
  add_index "logging_file_submission_logs", ["mongo_file_id"], name: "index_logging_file_submission_logs_on_mongo_file_id", using: :btree
  add_index "logging_file_submission_logs", ["mongo_id"], name: "index_logging_file_submission_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_file_submission_logs", ["mongo_target_id"], name: "index_logging_file_submission_logs_on_mongo_target_id", using: :btree
  add_index "logging_file_submission_logs", ["mongo_user_id"], name: "index_logging_file_submission_logs_on_mongo_user_id", using: :btree

  create_table "logging_folder_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.string   "mongo_target_id",     limit: 24
    t.string   "mongo_old_parent_id", limit: 24
    t.string   "mongo_group_id",      limit: 24
    t.string   "endpoint_source",     limit: 10
  end

  add_index "logging_folder_logs", ["account_id", "created_at"], name: "index_logging_folder_logs_on_ai_ca", using: :btree
  add_index "logging_folder_logs", ["category_id"], name: "index_logging_folder_logs_on_category_id", using: :btree
  add_index "logging_folder_logs", ["mongo_id"], name: "index_logging_folder_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_folder_logs", ["mongo_target_id"], name: "index_logging_folder_logs_on_mongo_target_id", using: :btree
  add_index "logging_folder_logs", ["mongo_user_id"], name: "index_logging_folder_logs_on_mongo_user_id", using: :btree

  create_table "logging_gradebook_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "params"
    t.json     "response"
  end

  add_index "logging_gradebook_logs", ["account_id"], name: "index_logging_gradebook_logs_on_account_id", using: :btree
  add_index "logging_gradebook_logs", ["category_id"], name: "index_logging_gradebook_logs_on_category_id", using: :btree
  add_index "logging_gradebook_logs", ["mongo_id"], name: "index_logging_gradebook_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_gradebook_logs", ["mongo_user_id"], name: "index_logging_gradebook_logs_on_mongo_user_id", using: :btree

  create_table "logging_parent_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id"
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.string   "mongo_parent_id",     limit: 24
    t.string   "mongo_student_id",    limit: 24
    t.string   "mongo_admin_user_id", limit: 24
  end

  add_index "logging_parent_logs", ["account_id", "created_at"], name: "index_logging_parent_logs_on_ai_ca", using: :btree
  add_index "logging_parent_logs", ["category_id"], name: "index_logging_parent_logs_on_category_id", using: :btree
  add_index "logging_parent_logs", ["mongo_id"], name: "index_logging_parent_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_parent_logs", ["mongo_parent_id"], name: "index_logging_parent_logs_on_mongo_parent_id", using: :btree
  add_index "logging_parent_logs", ["mongo_user_id"], name: "index_logging_parent_logs_on_mongo_user_id", using: :btree

  create_table "logging_question_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.uuid     "target_id"
  end

  add_index "logging_question_logs", ["account_id"], name: "index_logging_question_logs_on_account_id", using: :btree
  add_index "logging_question_logs", ["category_id"], name: "index_logging_question_logs_on_category_id", using: :btree
  add_index "logging_question_logs", ["mongo_user_id"], name: "index_logging_question_logs_on_mongo_user_id", using: :btree
  add_index "logging_question_logs", ["target_id"], name: "index_logging_question_logs_on_target_id", using: :btree

  create_table "logging_quiz_attempt_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.uuid     "target_id"
  end

  add_index "logging_quiz_attempt_logs", ["account_id"], name: "index_logging_quiz_attempt_logs_on_account_id", using: :btree
  add_index "logging_quiz_attempt_logs", ["category_id"], name: "index_logging_quiz_attempt_logs_on_category_id", using: :btree
  add_index "logging_quiz_attempt_logs", ["mongo_user_id"], name: "index_logging_quiz_attempt_logs_on_mongo_user_id", using: :btree
  add_index "logging_quiz_attempt_logs", ["target_id"], name: "index_logging_quiz_attempt_logs_on_target_id", using: :btree

  create_table "logging_quiz_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.uuid     "target_id"
  end

  add_index "logging_quiz_logs", ["account_id"], name: "index_logging_quiz_logs_on_account_id", using: :btree
  add_index "logging_quiz_logs", ["category_id"], name: "index_logging_quiz_logs_on_category_id", using: :btree
  add_index "logging_quiz_logs", ["mongo_user_id"], name: "index_logging_quiz_logs_on_mongo_user_id", using: :btree
  add_index "logging_quiz_logs", ["target_id"], name: "index_logging_quiz_logs_on_target_id", using: :btree

  create_table "logging_school_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.string   "mongo_target_id",     limit: 24
  end

  add_index "logging_school_logs", ["account_id", "created_at"], name: "index_logging_school_logs_on_ai_ca", using: :btree
  add_index "logging_school_logs", ["category_id"], name: "index_logging_school_logs_on_category_id", using: :btree
  add_index "logging_school_logs", ["mongo_id"], name: "index_logging_school_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_school_logs", ["mongo_target_id"], name: "index_logging_school_logs_on_mongo_target_id", using: :btree
  add_index "logging_school_logs", ["mongo_user_id"], name: "index_logging_school_logs_on_mongo_user_id", using: :btree

  create_table "logging_user_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",            limit: 24
    t.uuid     "account_id",                      null: false
    t.integer  "category_id",                     null: false
    t.datetime "created_at",                      null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.string   "mongo_target_id",     limit: 24
    t.string   "user_name",           limit: 255
    t.string   "endpoint_source",     limit: 10
  end

  add_index "logging_user_logs", ["account_id", "created_at"], name: "index_logging_user_logs_on_ai_ca", using: :btree
  add_index "logging_user_logs", ["category_id"], name: "index_logging_user_logs_on_category_id", using: :btree
  add_index "logging_user_logs", ["mongo_id"], name: "index_logging_user_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_user_logs", ["mongo_target_id"], name: "index_logging_user_logs_on_mongo_target_id", using: :btree
  add_index "logging_user_logs", ["mongo_user_id"], name: "index_logging_user_logs_on_mongo_user_id", using: :btree

  create_table "logging_web_dav_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",      limit: 24
    t.uuid     "account_id",                null: false
    t.integer  "category_id",               null: false
    t.datetime "created_at",                null: false
    t.string   "mongo_user_id", limit: 24
    t.inet     "ip"
    t.string   "user_agent",    limit: 255
    t.string   "file_path",     limit: 500
    t.string   "action",        limit: 10
    t.string   "code",          limit: 6
    t.integer  "size"
  end

  add_index "logging_web_dav_logs", ["account_id", "created_at"], name: "index_logging_web_dav_logs_on_ai_ca", using: :btree
  add_index "logging_web_dav_logs", ["category_id"], name: "index_logging_web_dav_logs_on_category_id", using: :btree
  add_index "logging_web_dav_logs", ["created_at"], name: "index_logging_web_dav_logs_on_created_at", using: :btree
  add_index "logging_web_dav_logs", ["file_path"], name: "index_logging_web_dav_logs_on_file_path", using: :btree
  add_index "logging_web_dav_logs", ["mongo_id"], name: "index_logging_web_dav_logs_on_mongo_id", unique: true, using: :btree
  add_index "logging_web_dav_logs", ["mongo_user_id", "created_at"], name: "index_logging_web_dav_logs_on_mui_ca", using: :btree

  create_table "logging_website_file_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                         null: false
    t.integer  "category_id",                        null: false
    t.datetime "created_at",                         null: false
    t.inet     "ip"
    t.string   "mongo_file_id",           limit: 24, null: false
    t.string   "mongo_group_id",          limit: 24
    t.string   "mongo_account_domain_id", limit: 24, null: false
    t.uuid     "website_id",                         null: false
    t.integer  "file_size"
  end

  add_index "logging_website_file_logs", ["account_id"], name: "index_logging_website_file_logs_on_account_id", using: :btree
  add_index "logging_website_file_logs", ["category_id"], name: "index_logging_website_file_logs_on_category_id", using: :btree
  add_index "logging_website_file_logs", ["mongo_group_id"], name: "index_logging_website_file_logs_on_mongo_group_id", using: :btree
  add_index "logging_website_file_logs", ["website_id"], name: "index_logging_website_file_logs_on_website_id", using: :btree

  create_table "logging_website_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.uuid     "target_id"
  end

  add_index "logging_website_logs", ["account_id"], name: "index_logging_website_logs_on_account_id", using: :btree
  add_index "logging_website_logs", ["category_id"], name: "index_logging_website_logs_on_category_id", using: :btree
  add_index "logging_website_logs", ["mongo_user_id"], name: "index_logging_website_logs_on_mongo_user_id", using: :btree
  add_index "logging_website_logs", ["target_id"], name: "index_logging_website_logs_on_target_id", using: :btree

  create_table "logging_website_page_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.uuid     "target_id"
  end

  add_index "logging_website_page_logs", ["account_id"], name: "index_logging_website_page_logs_on_account_id", using: :btree
  add_index "logging_website_page_logs", ["category_id"], name: "index_logging_website_page_logs_on_category_id", using: :btree
  add_index "logging_website_page_logs", ["mongo_user_id"], name: "index_logging_website_page_logs_on_mongo_user_id", using: :btree
  add_index "logging_website_page_logs", ["target_id"], name: "index_logging_website_page_logs_on_target_id", using: :btree

  create_table "logging_website_permission_logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                     null: false
    t.integer  "category_id",                    null: false
    t.datetime "created_at",                     null: false
    t.string   "mongo_user_id",       limit: 24
    t.string   "mongo_actor_user_id", limit: 24
    t.inet     "ip"
    t.json     "change"
    t.uuid     "target_id"
  end

  add_index "logging_website_permission_logs", ["account_id"], name: "index_logging_website_permission_logs_on_account_id", using: :btree
  add_index "logging_website_permission_logs", ["category_id"], name: "index_logging_website_permission_logs_on_category_id", using: :btree
  add_index "logging_website_permission_logs", ["mongo_user_id"], name: "index_logging_website_permission_logs_on_mongo_user_id", using: :btree
  add_index "logging_website_permission_logs", ["target_id"], name: "index_logging_website_permission_logs_on_target_id", using: :btree

  create_table "logging_win_forms_app_outcomes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",         limit: 24
    t.uuid     "account_id"
    t.string   "mongo_account_id", limit: 24
    t.boolean  "success",                      default: true,  null: false
    t.boolean  "insecure",                     default: false, null: false
    t.string   "app_version",      limit: 10
    t.string   "drive",            limit: 2
    t.string   "machine_name",     limit: 255
    t.integer  "os_platform",                  default: -1,    null: false
    t.string   "os_version",       limit: 255
    t.string   "os_service_pack",  limit: 255
    t.integer  "office_version"
    t.string   "user_name",        limit: 255
    t.string   "bad_password",     limit: 255
    t.text     "error"
    t.inet     "ip"
    t.datetime "created_at"
  end

  add_index "logging_win_forms_app_outcomes", ["created_at"], name: "index_logging_win_forms_app_outcomes_on_created_at", using: :btree
  add_index "logging_win_forms_app_outcomes", ["mongo_account_id"], name: "index_logging_win_forms_app_outcomes_on_mongo_account_id", using: :btree
  add_index "logging_win_forms_app_outcomes", ["mongo_id"], name: "index_logging_win_forms_app_outcomes_on_mongo_id", using: :btree

  create_table "logging_win_forms_app_runs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "mongo_id",         limit: 24
    t.uuid     "account_id"
    t.string   "mongo_account_id", limit: 24
    t.boolean  "insecure",                     default: false, null: false
    t.string   "app_version",      limit: 10
    t.string   "drive",            limit: 2
    t.string   "machine_name",     limit: 255
    t.integer  "os_platform",                  default: -1,    null: false
    t.string   "os_version",       limit: 255
    t.string   "os_service_pack",  limit: 255
    t.inet     "ip"
    t.integer  "runs",                         default: 0,     null: false
    t.datetime "last_run_at"
  end

  add_index "logging_win_forms_app_runs", ["account_id", "machine_name", "app_version"], name: "logging_win_forms_app_runs_on_ai_mn_av", using: :btree
  add_index "logging_win_forms_app_runs", ["last_run_at"], name: "index_logging_win_forms_app_runs_on_last_run_at", using: :btree
  add_index "logging_win_forms_app_runs", ["mongo_id"], name: "index_logging_win_forms_app_runs_on_mongo_id", using: :btree

  create_table "mobile_push_devices", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "user_type",           limit: 255
    t.string   "mongo_user_id",       limit: 24
    t.string   "application",         limit: 255
    t.string   "platform",            limit: 255
    t.string   "device_token",        limit: 255
    t.string   "amazon_endpoint_arn", limit: 255
    t.datetime "last_push_at"
    t.integer  "push_count",                      default: 0
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "active",                          default: true
  end

  add_index "mobile_push_devices", ["device_token"], name: "index_mobile_push_devices_on_device_token", using: :btree
  add_index "mobile_push_devices", ["mongo_user_id"], name: "index_mobile_push_devices_on_mongo_user_id", using: :btree

  create_table "mongo_grid_files", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "grid_cluster_id",  limit: 2,                     null: false
    t.string   "grid_file_id",     limit: 24,                    null: false
    t.integer  "content_size",     limit: 8,                     null: false
    t.string   "content_hash",     limit: 128,                   null: false
    t.datetime "created_at",                                     null: false
    t.datetime "touched_at",                   default: "now()", null: false
    t.uuid     "stored_file_id"
    t.string   "backpack_file_id", limit: 24
  end

  add_index "mongo_grid_files", ["content_size", "content_hash"], name: "index_mongo_grid_files_on_content_size_and_content_hash", using: :btree
  add_index "mongo_grid_files", ["grid_file_id"], name: "index_mongo_grid_files_on_grid_file_id", unique: true, using: :btree
  add_index "mongo_grid_files", ["stored_file_id"], name: "index_mongo_grid_files_on_stored_file_id", using: :btree
  add_index "mongo_grid_files", ["touched_at"], name: "index_mongo_grid_files_on_touched_at", using: :btree

  create_table "offline_item_tasks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "locked_at"
    t.string   "locked_by",             limit: 255
    t.string   "category",              limit: 255
    t.string   "mongo_target_id",       limit: 24
    t.uuid     "target_id"
    t.string   "target_type",           limit: 255
    t.datetime "content_last_modified"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "error"
  end

  add_index "offline_item_tasks", ["created_at"], name: "index_offline_item_tasks_on_created_at", using: :btree
  add_index "offline_item_tasks", ["locked_at"], name: "index_offline_item_tasks_on_locked_at", using: :btree
  add_index "offline_item_tasks", ["mongo_target_id"], name: "index_offline_item_tasks_on_mongo_target_id", using: :btree
  add_index "offline_item_tasks", ["target_id"], name: "index_offline_item_tasks_on_target_id", using: :btree

  create_table "offline_items", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "content_last_modified"
    t.uuid     "user_id"
    t.string   "mongo_user_id",         limit: 255
    t.string   "mongo_offlineable_id",  limit: 24
    t.uuid     "offlineable_id"
    t.string   "offlineable_type",      limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "offline_items", ["updated_at"], name: "index_offline_items_on_updated_at", using: :btree

  create_table "qz_attempts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "number"
    t.integer  "position",                             default: -1
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.uuid     "quiz_id"
    t.string   "mongo_user_id",            limit: 255
    t.integer  "number_of_questions"
    t.integer  "furthest_position",                    default: -1
    t.string   "gradebook_status",         limit: 255
    t.json     "gradebook_data"
    t.float    "auto_earned_points"
    t.float    "auto_scoring_points"
    t.float    "auto_extra_credit_points"
    t.datetime "last_auto_scored_at"
    t.float    "manual_earned_points"
    t.datetime "manual_scored_at"
    t.string   "mongo_reviewer_id",        limit: 24
  end

  add_index "qz_attempts", ["mongo_user_id"], name: "index_qz_attempts_on_mongo_user_id", using: :btree
  add_index "qz_attempts", ["quiz_id"], name: "index_qz_attempts_on_quiz_id", using: :btree

  create_table "qz_choice_question_answers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "index"
    t.boolean  "selected",            default: false
    t.uuid     "question_attempt_id"
    t.uuid     "choice_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "qz_choice_question_answers", ["choice_id"], name: "index_qz_choice_question_answers_on_choice_id", using: :btree
  add_index "qz_choice_question_answers", ["index"], name: "index_qz_choice_question_answers_on_index", using: :btree
  add_index "qz_choice_question_answers", ["question_attempt_id"], name: "index_qz_choice_question_answers_on_question_attempt_id", using: :btree
  add_index "qz_choice_question_answers", ["selected"], name: "index_qz_choice_question_answers_on_selected", using: :btree

  create_table "qz_choice_question_profiles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.boolean  "multiple_select",   default: false
    t.integer  "min_select"
    t.integer  "max_select"
    t.uuid     "question_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "number_of_choices", default: 0
  end

  add_index "qz_choice_question_profiles", ["question_id"], name: "index_qz_choice_question_profiles_on_question_id", using: :btree

  create_table "qz_choices", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "index"
    t.float    "credit",      default: 0.0
    t.text     "text",        default: ""
    t.text     "feedback",    default: ""
    t.uuid     "question_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
  end

  add_index "qz_choices", ["deleted_at"], name: "index_qz_choices_on_deleted_at", using: :btree
  add_index "qz_choices", ["question_id"], name: "index_qz_choices_on_question_profile_id", using: :btree

  create_table "qz_essay_question_answers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "text"
    t.uuid     "question_attempt_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "qz_essay_question_answers", ["question_attempt_id"], name: "index_qz_essay_question_answers_on_question_attempt_id", using: :btree

  create_table "qz_fill_patterns", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "index"
    t.string   "text",            limit: 255
    t.string   "pattern_type",    limit: 255
    t.float    "credit",                      default: 0.0
    t.text     "feedback"
    t.json     "pattern_options"
    t.uuid     "question_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "qz_fill_patterns", ["question_id"], name: "index_qz_fill_patterns_on_question_id", using: :btree

  create_table "qz_fill_question_answers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "text",                limit: 255
    t.uuid     "matching_pattern_id"
    t.uuid     "question_attempt_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "qz_fill_question_answers", ["matching_pattern_id"], name: "index_qz_fill_question_answers_on_matching_pattern_id", using: :btree
  add_index "qz_fill_question_answers", ["question_attempt_id"], name: "index_qz_fill_question_answers_on_question_attempt_id", unique: true, using: :btree

  create_table "qz_fill_question_profiles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "number_of_patterns", default: 0
    t.uuid     "question_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "qz_fill_question_profiles", ["question_id"], name: "index_qz_fill_question_profiles_on_question_id", using: :btree

  create_table "qz_question_attempts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "type",                limit: 255
    t.integer  "index"
    t.datetime "seen_at"
    t.datetime "answered_at"
    t.datetime "skipped_at"
    t.boolean  "flagged",                         default: false
    t.uuid     "question_id"
    t.uuid     "quiz_attempt_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.float    "auto_score_points"
    t.datetime "last_auto_scored_at"
    t.float    "manual_score_points"
    t.datetime "manual_scored_at"
    t.text     "manual_feedback"
  end

  add_index "qz_question_attempts", ["question_id"], name: "index_qz_question_attempts_on_question_id", using: :btree
  add_index "qz_question_attempts", ["quiz_attempt_id"], name: "index_qz_question_attempts_on_quiz_attempt_id", using: :btree
  add_index "qz_question_attempts", ["type"], name: "index_qz_question_attempts_on_type", using: :btree

  create_table "qz_questions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "type",            limit: 255
    t.integer  "index"
    t.text     "prompt"
    t.float    "points"
    t.boolean  "extra_credit",                default: false
    t.boolean  "shuffle_answers",             default: false
    t.uuid     "quiz_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.datetime "deleted_at"
    t.text     "feedback"
  end

  add_index "qz_questions", ["deleted_at"], name: "index_qz_questions_on_deleted_at", using: :btree
  add_index "qz_questions", ["quiz_id"], name: "index_qz_questions_on_quiz_id", using: :btree
  add_index "qz_questions", ["type"], name: "index_qz_questions_on_type", using: :btree

  create_table "qz_quizzes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "time_limit"
    t.integer  "attempts_allowed",                   default: 1
    t.datetime "deleted_at"
    t.boolean  "shuffle_questions",                  default: false
    t.boolean  "allow_skip",                         default: true
    t.boolean  "allow_revisit",                      default: true
    t.string   "mongo_assignment_id",    limit: 24
    t.uuid     "assignment_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.json     "feedback_configuration"
    t.text     "feedback"
    t.integer  "number_of_questions",                default: 0
    t.float    "curve_points",                       default: 0.0
    t.boolean  "use_seb",                            default: false
    t.string   "seb_key",                limit: 255
  end

  add_index "qz_quizzes", ["assignment_id"], name: "index_qz_quizzes_on_assignment_id", using: :btree
  add_index "qz_quizzes", ["deleted_at"], name: "index_qz_quizzes_on_deleted_at", using: :btree
  add_index "qz_quizzes", ["mongo_assignment_id"], name: "index_qz_quizzes_on_mongo_assignment_id", using: :btree

  create_table "scheduled_event_tasks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "exchange_name", limit: 255, null: false
    t.json     "payload"
    t.string   "subject_type",  limit: 50
    t.string   "subject_id",    limit: 36
    t.datetime "run_at",                    null: false
    t.datetime "locked_at"
    t.string   "locked_by",     limit: 255
    t.text     "error"
    t.datetime "updated_at",                null: false
  end

  add_index "scheduled_event_tasks", ["exchange_name"], name: "index_scheduled_event_tasks_on_exchange_name", using: :btree
  add_index "scheduled_event_tasks", ["run_at", "locked_at", "error"], name: "index_scheduled_event_tasks_on_run_at_and_locked_at_and_error", using: :btree
  add_index "scheduled_event_tasks", ["subject_type", "subject_id"], name: "index_scheduled_event_tasks_on_subject_type_and_subject_id", using: :btree

  create_table "standard_sets", id: false, force: :cascade do |t|
    t.string "id"
    t.string "required"
    t.string "index"
    t.string "jurisdiction_id"
    t.string "title"
    t.string "subject"
    t.json   "meta"
  end

  create_table "stored_files", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                                 null: false
    t.integer  "kind_id",                                    null: false
    t.string   "object_name",       limit: 100,              null: false
    t.string   "content_type",      limit: 255,              null: false
    t.integer  "content_length",    limit: 8,   default: 0,  null: false
    t.string   "content_hash",      limit: 128,              null: false
    t.string   "md5",               limit: 32,               null: false
    t.integer  "status_id",                                  null: false
    t.json     "status_detail",                 default: {}, null: false
    t.datetime "touched_at",                                 null: false
    t.datetime "uploaded_at",                                null: false
    t.datetime "created_at",                                 null: false
    t.datetime "purged_at"
    t.integer  "grid_cluster_id",   limit: 2
    t.string   "grid_file_id",      limit: 24
    t.datetime "migrate_locked_at"
    t.string   "migrate_locked_by", limit: 255
  end

  add_index "stored_files", ["account_id"], name: "index_stored_files_on_account_id", using: :btree
  add_index "stored_files", ["content_length", "content_hash"], name: "index_stored_files_on_content_length_and_content_hash", using: :btree
  add_index "stored_files", ["created_at"], name: "index_stored_files_on_created_at", using: :btree
  add_index "stored_files", ["grid_cluster_id", "status_id", "migrate_locked_at"], name: "index_stored_files_on_gci_si_mla", where: "(grid_cluster_id IS NOT NULL)", using: :btree
  add_index "stored_files", ["grid_file_id"], name: "index_stored_files_on_grid_file_id", using: :btree
  add_index "stored_files", ["kind_id"], name: "index_stored_files_on_kind_id", using: :btree
  add_index "stored_files", ["status_id"], name: "index_stored_files_on_status_id", using: :btree
  add_index "stored_files", ["touched_at"], name: "index_stored_files_on_touched_at", using: :btree
  add_index "stored_files", ["uploaded_at"], name: "index_stored_files_on_uploaded_at", using: :btree

  create_table "user_agent_records", force: :cascade do |t|
    t.string   "mongo_user_id",   limit: 24,              null: false
    t.string   "account_id",      limit: 255,             null: false
    t.string   "ua_string",       limit: 255,             null: false
    t.string   "os",              limit: 255
    t.string   "os_version",      limit: 255
    t.string   "client",          limit: 255
    t.string   "client_version",  limit: 255
    t.string   "device",          limit: 255
    t.string   "mobile_app_name", limit: 255
    t.integer  "hit_counter",                 default: 0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "user_agent_records", ["mobile_app_name"], name: "index_user_agent_records_on_mobile_app_name", using: :btree
  add_index "user_agent_records", ["mongo_user_id", "ua_string"], name: "index_user_agent_records_on_mongo_user_id_and_ua_string", unique: true, using: :btree
  add_index "user_agent_records", ["ua_string"], name: "index_user_agent_records_on_ua_string", using: :btree

  create_table "user_notifications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "subscriber_type",      limit: 10,                    null: false
    t.string   "mongo_subscriber_id",  limit: 24,                    null: false
    t.string   "target_user_type",     limit: 10,                    null: false
    t.string   "mongo_target_user_id", limit: 24,                    null: false
    t.string   "subject_type",         limit: 50,                    null: false
    t.string   "subject_id",           limit: 36,                    null: false
    t.string   "action",               limit: 50,                    null: false
    t.string   "style",                limit: 10, default: "normal", null: false
    t.text     "message_text",                                       null: false
    t.datetime "visible_at",                                         null: false
    t.datetime "seen_at"
    t.datetime "read_at"
    t.datetime "updated_at",                                         null: false
    t.boolean  "internal_only",                   default: false
  end

  add_index "user_notifications", ["subject_type", "subject_id"], name: "index_user_notifications_on_subject_type_and_subject_id", using: :btree
  add_index "user_notifications", ["subscriber_type", "mongo_subscriber_id", "read_at"], name: "index_user_notifications_st_msi_ra", using: :btree
  add_index "user_notifications", ["target_user_type", "mongo_target_user_id"], name: "index_user_notifications_tut_mtui", using: :btree
  add_index "user_notifications", ["visible_at"], name: "index_user_notifications_on_visible_at", using: :btree

  create_table "user_terms_acceptances", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",               null: false
    t.string   "mongo_user_id", limit: 24, null: false
    t.string   "terms_version", limit: 16, null: false
    t.inet     "ip",                       null: false
    t.datetime "created_at",               null: false
  end

  add_index "user_terms_acceptances", ["account_id"], name: "index_user_terms_acceptances_on_account_id", using: :btree
  add_index "user_terms_acceptances", ["mongo_user_id"], name: "index_user_terms_acceptances_on_mongo_user_id", using: :btree

  create_table "websites_block_placements", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "block_version_id",            null: false
    t.uuid     "website_id",                  null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.string   "block_position",   limit: 50, null: false
  end

  add_index "websites_block_placements", ["block_version_id"], name: "ix_websites_block_placements_blkvers_id", using: :btree
  add_index "websites_block_placements", ["website_id"], name: "ix_websites_block_placements_website_id", using: :btree

  create_table "websites_block_versions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "block_id",                       default: "uuid_generate_v4()", null: false
    t.string   "block_type",          limit: 50,                                null: false
    t.integer  "version_number",                 default: 1,                    null: false
    t.json     "json_content",                                                  null: false
    t.string   "mongo_created_by_id", limit: 24
    t.string   "mongo_updated_by_id", limit: 24
    t.datetime "deleted_at"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  add_index "websites_block_versions", ["block_id", "version_number"], name: "index_websites_block_versions_on_block_id_and_version_number", unique: true, using: :btree

  create_table "websites_page_hierarchies", id: false, force: :cascade do |t|
    t.uuid    "ancestor_id",   null: false
    t.uuid    "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "websites_page_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "udx_websites_page_hierarchies_anc_desc", unique: true, using: :btree
  add_index "websites_page_hierarchies", ["descendant_id"], name: "idx_websites_page_hierarchies_desc", using: :btree

  create_table "websites_page_permissions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "page_id",                  null: false
    t.string   "mongo_user_id", limit: 24, null: false
    t.datetime "deleted_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "websites_page_permissions", ["mongo_user_id"], name: "ix_websites_page_perms_mongo_user_id", using: :btree
  add_index "websites_page_permissions", ["page_id"], name: "ix_websites_page_perms_page_id", using: :btree

  create_table "websites_page_versions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "page_id",                                                             null: false
    t.uuid     "website_id",                                                          null: false
    t.uuid     "parent_id"
    t.integer  "parent_version_number"
    t.string   "url_part",              limit: 255,                                   null: false
    t.text     "title",                                                               null: false
    t.string   "status",                limit: 10,                                    null: false
    t.integer  "version_number",                    default: 0,                       null: false
    t.integer  "menu_order",                        default: 1,                       null: false
    t.boolean  "in_menu",                           default: true,                    null: false
    t.boolean  "in_top_menu",                       default: false,                   null: false
    t.string   "mongo_created_by_id",   limit: 24
    t.string   "mongo_updated_by_id",   limit: 24
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.string   "block_version_ids",                 default: [],                      null: false, array: true
    t.boolean  "visible",                           default: true,                    null: false
    t.string   "page_type",             limit: 255, default: "Websites::ContentPage", null: false
  end

  add_index "websites_page_versions", ["page_id"], name: "ix_websites_page_versions_page_id", using: :btree
  add_index "websites_page_versions", ["parent_id"], name: "ix_websites_page_versions_parent_id", using: :btree
  add_index "websites_page_versions", ["website_id"], name: "ix_websites_page_versions_website_id", using: :btree

  create_table "websites_pages", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "website_id",                                                        null: false
    t.uuid     "parent_id"
    t.string   "url_part",            limit: 255,                                   null: false
    t.text     "title",                                                             null: false
    t.string   "status",              limit: 10,                                    null: false
    t.integer  "version_number",                  default: 0,                       null: false
    t.integer  "menu_order",                      default: 1,                       null: false
    t.boolean  "in_menu",                         default: true,                    null: false
    t.boolean  "in_top_menu",                     default: false,                   null: false
    t.string   "mongo_created_by_id", limit: 24
    t.string   "mongo_updated_by_id", limit: 24
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.integer  "next_version_number",             default: 1,                       null: false
    t.string   "block_version_ids",               default: [],                      null: false, array: true
    t.boolean  "visible",                         default: true,                    null: false
    t.string   "type",                limit: 255, default: "Websites::ContentPage", null: false
  end

  add_index "websites_pages", ["parent_id"], name: "ix_websites_pages_parent_id", using: :btree
  add_index "websites_pages", ["website_id", "parent_id", "url_part"], name: "uix_websites_pages_pub_path", unique: true, where: "((status)::text = 'published'::text)", using: :btree
  add_index "websites_pages", ["website_id"], name: "ix_websites_pages_website_id", using: :btree

  create_table "websites_website_groups", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "website_id",                null: false
    t.string   "mongo_group_id", limit: 24, null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "websites_website_groups", ["website_id"], name: "ix_websites_website_groups_website_id", using: :btree

  create_table "websites_websites", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                                                null: false
    t.boolean  "is_district_site",                          default: false, null: false
    t.boolean  "toolbar_show_on_children",                  default: true,  null: false
    t.boolean  "toolbar_include_school_links",              default: true,  null: false
    t.string   "style_structure",                limit: 50,                 null: false
    t.string   "style_color",                    limit: 50,                 null: false
    t.boolean  "use_parent_style_structure",                default: true,  null: false
    t.boolean  "use_parent_style_color",                    default: true,  null: false
    t.boolean  "use_parent_header",                         default: true,  null: false
    t.boolean  "use_parent_footer",                         default: true,  null: false
    t.string   "mongo_updated_by_id",            limit: 24
    t.datetime "deleted_at"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.boolean  "force_children_style_structure",            default: false, null: false
    t.boolean  "force_children_style_color",                default: false, null: false
    t.boolean  "force_children_header",                     default: false, null: false
    t.boolean  "force_children_footer",                     default: false, null: false
    t.boolean  "alert_enabled",                             default: false, null: false
    t.boolean  "alert_children_enabled",                    default: false, null: false
  end

  add_index "websites_websites", ["account_id", "is_district_site"], name: "index_websites_websites_on_account_id_and_district_site", using: :btree

  add_foreign_key "logging_quiz_attempt_logs", "qz_attempts", column: "target_id", name: "logging_quiz_attempt_logs_target_id_fk", on_delete: :nullify
  add_foreign_key "qz_attempts", "qz_quizzes", column: "quiz_id", name: "qz_attempts_quiz_id_fk", on_delete: :cascade
  add_foreign_key "qz_choice_question_answers", "qz_choices", column: "choice_id", name: "qz_choice_question_answers_choice_id_fk", on_delete: :cascade
  add_foreign_key "qz_choice_question_answers", "qz_question_attempts", column: "question_attempt_id", name: "qz_choice_question_answers_question_attempt_id_fk", on_delete: :cascade
  add_foreign_key "qz_choice_question_profiles", "qz_questions", column: "question_id", name: "qz_choice_question_profiles_question_id_fk", on_delete: :nullify
  add_foreign_key "qz_choices", "qz_questions", column: "question_id", name: "qz_choices_question_id_fk", on_delete: :cascade
  add_foreign_key "qz_essay_question_answers", "qz_question_attempts", column: "question_attempt_id", name: "qz_essay_question_answers_question_attempt_id_fk", on_delete: :cascade
  add_foreign_key "qz_fill_patterns", "qz_questions", column: "question_id", name: "qz_fill_patterns_question_id_fk", on_delete: :cascade
  add_foreign_key "qz_fill_question_answers", "qz_fill_patterns", column: "matching_pattern_id", name: "qz_fill_question_answers_matching_pattern_id_fk", on_delete: :nullify
  add_foreign_key "qz_fill_question_answers", "qz_question_attempts", column: "question_attempt_id", name: "qz_fill_question_answers_question_attempt_id_fk", on_delete: :cascade
  add_foreign_key "qz_fill_question_profiles", "qz_questions", column: "question_id", name: "qz_fill_question_profiles_question_id_fk", on_delete: :cascade
  add_foreign_key "qz_question_attempts", "qz_attempts", column: "quiz_attempt_id", name: "qz_question_attempts_quiz_attempt_id_fk", on_delete: :cascade
  add_foreign_key "qz_question_attempts", "qz_questions", column: "question_id", name: "qz_question_attempts_question_id_fk", on_delete: :cascade
  add_foreign_key "qz_questions", "qz_quizzes", column: "quiz_id", name: "qz_questions_quiz_id_fk", on_delete: :cascade
  add_foreign_key "standard_sets", "jurisdictions"
  add_foreign_key "websites_block_placements", "websites_block_versions", column: "block_version_id", name: "websites_block_placements_block_version_id_fk"
  add_foreign_key "websites_block_placements", "websites_websites", column: "website_id", name: "websites_block_placements_website_id_fk"
  add_foreign_key "websites_page_permissions", "websites_pages", column: "page_id", name: "websites_page_permissions_page_id_fk"
  add_foreign_key "websites_page_versions", "websites_pages", column: "page_id", name: "websites_page_versions_page_id_fk"
  add_foreign_key "websites_page_versions", "websites_pages", column: "parent_id", name: "websites_page_versions_parent_id_fk"
  add_foreign_key "websites_page_versions", "websites_websites", column: "website_id", name: "websites_page_versions_website_id_fk"
  add_foreign_key "websites_pages", "websites_pages", column: "parent_id", name: "websites_pages_parent_id_fk"
  add_foreign_key "websites_pages", "websites_websites", column: "website_id", name: "websites_pages_website_id_fk"
  add_foreign_key "websites_website_groups", "websites_websites", column: "website_id", name: "websites_website_groups_website_id_fk"
end
