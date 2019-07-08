# frozen_string_literal: true

class MsgSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
end
