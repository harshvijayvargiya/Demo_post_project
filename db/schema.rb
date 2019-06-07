# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_605_121_846) do
  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.integer 'resource_id'
    t.string 'author_type'
    t.integer 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author_type_and_author_id'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource_type_and_resource_id'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'average_caches', force: :cascade do |t|
    t.integer 'rater_id'
    t.string 'rateable_type'
    t.integer 'rateable_id'
    t.float 'avg', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[rateable_type rateable_id], name: 'index_average_caches_on_rateable_type_and_rateable_id'
    t.index ['rater_id'], name: 'index_average_caches_on_rater_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'body'
    t.integer 'user_id'
    t.integer 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_comments_on_post_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'impressions', force: :cascade do |t|
    t.string 'impressionable_type'
    t.integer 'impressionable_id'
    t.integer 'user_id'
    t.string 'controller_name'
    t.string 'action_name'
    t.string 'view_name'
    t.string 'request_hash'
    t.string 'ip_address'
    t.string 'session_hash'
    t.text 'message'
    t.text 'referrer'
    t.text 'params'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[controller_name action_name ip_address], name: 'controlleraction_ip_index'
    t.index %w[controller_name action_name request_hash], name: 'controlleraction_request_index'
    t.index %w[controller_name action_name session_hash], name: 'controlleraction_session_index'
    t.index %w[impressionable_type impressionable_id ip_address], name: 'poly_ip_index'
    t.index %w[impressionable_type impressionable_id params], name: 'poly_params_request_index'
    t.index %w[impressionable_type impressionable_id request_hash], name: 'poly_request_index'
    t.index %w[impressionable_type impressionable_id session_hash], name: 'poly_session_index'
    t.index %w[impressionable_type message impressionable_id], name: 'impressionable_type_message_index'
    t.index ['user_id'], name: 'index_impressions_on_user_id'
  end

  create_table 'overall_averages', force: :cascade do |t|
    t.string 'rateable_type'
    t.integer 'rateable_id'
    t.float 'overall_avg', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[rateable_type rateable_id], name: 'index_overall_averages_on_rateable_type_and_rateable_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'attachment'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.string 'status'
    t.integer 'count', default: 0
    t.integer 'impressions_count'
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'rates', force: :cascade do |t|
    t.integer 'rater_id'
    t.string 'rateable_type'
    t.integer 'rateable_id'
    t.float 'stars', null: false
    t.string 'dimension'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[rateable_id rateable_type], name: 'index_rates_on_rateable_id_and_rateable_type'
    t.index %w[rateable_type rateable_id], name: 'index_rates_on_rateable_type_and_rateable_id'
    t.index ['rater_id'], name: 'index_rates_on_rater_id'
  end

  create_table 'rating_caches', force: :cascade do |t|
    t.string 'cacheable_type'
    t.integer 'cacheable_id'
    t.float 'avg', null: false
    t.integer 'qty', null: false
    t.string 'dimension'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[cacheable_id cacheable_type], name: 'index_rating_caches_on_cacheable_id_and_cacheable_type'
    t.index %w[cacheable_type cacheable_id], name: 'index_rating_caches_on_cacheable_type_and_cacheable_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'provider'
    t.string 'uid'
    t.string 'token'
    t.integer 'expires_at'
    t.boolean 'expires'
    t.string 'refresh_token'
    t.string 'invitation_token'
    t.datetime 'invitation_created_at'
    t.datetime 'invitation_sent_at'
    t.datetime 'invitation_accepted_at'
    t.integer 'invitation_limit'
    t.string 'invited_by_type'
    t.integer 'invited_by_id'
    t.integer 'invitations_count', default: 0
    t.string 'first_name'
    t.string 'last_name'
    t.string 'role'
    t.string 'contact_number'
    t.string 'profile_picture'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['invitation_token'], name: 'index_users_on_invitation_token', unique: true
    t.index ['invitations_count'], name: 'index_users_on_invitations_count'
    t.index ['invited_by_id'], name: 'index_users_on_invited_by_id'
    t.index %w[invited_by_type invited_by_id], name: 'index_users_on_invited_by_type_and_invited_by_id'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
