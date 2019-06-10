# frozen_string_literal: true

class Post < ApplicationRecord
  paginates_per  1
  mount_uploader :attachment
  ratyrate_rateable 'attachment', 'content'
  is_impressionable counter_cache: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :is_public, -> { where(status: 'public') }
  scope :is_private, -> { where(status: 'private') }

  # TODO: need indented code
  def self.search(search)
    where('attachment LIKE ?', "%#{search}%")
    where('content LIKE ?', "%#{search}%")
  end

  def increase_visit
    self.count += 1
    save!
  end

end
