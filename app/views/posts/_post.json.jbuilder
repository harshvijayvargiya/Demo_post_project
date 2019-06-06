# frozen_string_literal: true

json.extract! post, :id, :attachment, :content, :created_at, :updated_at
json.url post_url(post, format: :json)
