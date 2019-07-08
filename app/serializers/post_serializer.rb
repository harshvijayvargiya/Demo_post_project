# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :attachment, :content, :user_id, :status, :count, :impressions_count
  def date
    object.date&.strftime('%d-%m-%Y')
  end
end
