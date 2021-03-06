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

ActiveRecord::Schema.define(version: 20150421153342) do

  create_table "base_versions", force: :cascade do |t|
    t.string   "name",       limit: 128, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "base_versions_enviroments", id: false, force: :cascade do |t|
    t.integer "base_version_id"
    t.integer "enviroment_id"
  end

  add_index "base_versions_enviroments", ["base_version_id"], name: "index_base_versions_enviroments_on_base_version_id"
  add_index "base_versions_enviroments", ["enviroment_id"], name: "index_base_versions_enviroments_on_enviroment_id"

  create_table "branches", force: :cascade do |t|
    t.string   "name",                   limit: 512,                 null: false
    t.integer  "repository_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "last_commit_identifier",             default: "",    null: false
    t.datetime "deleted_at"
    t.boolean  "deleted",                            default: false, null: false
  end

  add_index "branches", ["deleted_at"], name: "index_branches_on_deleted_at"
  add_index "branches", ["name"], name: "index_branches_on_name"
  add_index "branches", ["repository_id"], name: "index_branches_on_repository_id"

  create_table "build_artefacts", force: :cascade do |t|
    t.string   "file"
    t.integer  "build_job_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "filename"
  end

  add_index "build_artefacts", ["build_job_id"], name: "index_build_artefacts_on_build_job_id"

  create_table "build_job_queues", force: :cascade do |t|
    t.integer  "build_job_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "build_job_queues", ["build_job_id"], name: "index_build_job_queues_on_build_job_id"

  create_table "build_jobs", force: :cascade do |t|
    t.integer  "branch_id",                                  null: false
    t.integer  "base_version_id",                            null: false
    t.integer  "enviroment_id",                              null: false
    t.integer  "target_platform_id",                         null: false
    t.integer  "notify_user_id"
    t.integer  "started_by_user_id",                         null: false
    t.string   "comment",                    default: "",    null: false
    t.integer  "status",                                     null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "result",                     default: 0,     null: false
    t.integer  "commit_id"
    t.integer  "build_log_id"
    t.integer  "worker_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "full_version_id"
    t.string   "generate_build_numbers_url", default: "",    null: false
    t.boolean  "run_tests",                  default: false, null: false
  end

  add_index "build_jobs", ["base_version_id"], name: "index_build_jobs_on_base_version_id"
  add_index "build_jobs", ["branch_id"], name: "index_build_jobs_on_branch_id"
  add_index "build_jobs", ["build_log_id"], name: "index_build_jobs_on_build_log_id"
  add_index "build_jobs", ["commit_id"], name: "index_build_jobs_on_commit_id"
  add_index "build_jobs", ["enviroment_id"], name: "index_build_jobs_on_enviroment_id"
  add_index "build_jobs", ["full_version_id"], name: "index_build_jobs_on_full_version_id"
  add_index "build_jobs", ["notify_user_id"], name: "index_build_jobs_on_notify_user_id"
  add_index "build_jobs", ["started_by_user_id"], name: "index_build_jobs_on_started_by_user_id"
  add_index "build_jobs", ["target_platform_id"], name: "index_build_jobs_on_target_platform_id"
  add_index "build_jobs", ["worker_id"], name: "index_build_jobs_on_worker_id"

  create_table "build_logs", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "build_numbers", force: :cascade do |t|
    t.string   "branch",        limit: 1024, null: false
    t.string   "commit",        limit: 1024, null: false
    t.integer  "number",                     null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "enviroment_id"
  end

  add_index "build_numbers", ["branch"], name: "index_build_numbers_on_branch"
  add_index "build_numbers", ["enviroment_id"], name: "index_build_numbers_on_enviroment_id"

  create_table "commits", force: :cascade do |t|
    t.string   "identifier",              null: false
    t.datetime "datetime",                null: false
    t.string   "message",    default: "", null: false
    t.string   "author",     default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "commits", ["identifier"], name: "index_commits_on_identifier"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "enviroments", force: :cascade do |t|
    t.string   "title",                        limit: 1024,                 null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "default_build_number",                      default: 0,     null: false
    t.integer  "repository_id"
    t.string   "branches_filter",              limit: 2048, default: ""
    t.integer  "issue_tracker_id"
    t.text     "target_platforms_order"
    t.integer  "delete_build_jobs_older_than",              default: 0,     null: false
    t.integer  "tests_executor_id"
    t.boolean  "tests_enabled_by_default",                  default: false, null: false
  end

  add_index "enviroments", ["issue_tracker_id"], name: "index_enviroments_on_issue_tracker_id"
  add_index "enviroments", ["repository_id"], name: "index_enviroments_on_repository_id"
  add_index "enviroments", ["tests_executor_id"], name: "index_enviroments_on_tests_executor_id"
  add_index "enviroments", ["title"], name: "index_enviroments_on_title"

  create_table "full_versions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  create_table "home_page_contents", force: :cascade do |t|
    t.string   "title",      limit: 1024,             null: false
    t.string   "link",       limit: 4096
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "position",                default: 0, null: false
  end

  create_table "issue_trackers", force: :cascade do |t|
    t.string   "title",      limit: 1024, null: false
    t.string   "weblink",    limit: 4096, null: false
    t.string   "regex",      limit: 4096, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "repositories", force: :cascade do |t|
    t.string   "title",             limit: 512,  default: "",    null: false
    t.string   "path",              limit: 4096,                 null: false
    t.integer  "vcs_type",                                       null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "weblink_to_commit", limit: 4096
    t.boolean  "hook_enabled",                   default: false, null: false
    t.string   "hook_login",        limit: 128
    t.string   "hook_password",     limit: 128
  end

  create_table "target_platforms", force: :cascade do |t|
    t.string   "title",      limit: 512, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "target_platforms_workers", id: false, force: :cascade do |t|
    t.integer "target_platform_id"
    t.integer "worker_id"
  end

  add_index "target_platforms_workers", ["target_platform_id"], name: "index_target_platforms_workers_on_target_platform_id"
  add_index "target_platforms_workers", ["worker_id"], name: "index_target_platforms_workers_on_worker_id"

  create_table "tests_executors", force: :cascade do |t|
    t.string   "title",         limit: 1024, default: "", null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "run_params",                 default: "", null: false
    t.string   "artefact_name",              default: "", null: false
  end

  create_table "tests_results", force: :cascade do |t|
    t.string   "title",             default: "", null: false
    t.text     "data"
    t.integer  "tests_executor_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "build_job_id"
  end

  add_index "tests_results", ["build_job_id"], name: "index_tests_results_on_build_job_id"
  add_index "tests_results", ["tests_executor_id"], name: "index_tests_results_on_tests_executor_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                    default: false, null: false
    t.boolean  "approved",                 default: false, null: false
    t.string   "background_image"
    t.string   "background_image_opacity", default: "0.0", null: false
  end

  add_index "users", ["approved"], name: "index_users_on_approved"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "workers", force: :cascade do |t|
    t.string   "title",                         null: false
    t.string   "address",                       null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "priority",      default: 0,     null: false
    t.boolean  "disabled",      default: false, null: false
    t.boolean  "tests_support", default: false, null: false
  end

end
