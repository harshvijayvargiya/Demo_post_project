# frozen_string_literal: true

json.extract! msg, :id, :name, :description, :created_at, :updated_at
json.url msg_url(msg, format: :json)
