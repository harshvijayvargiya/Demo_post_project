# frozen_string_literal: true

class Post < ApplicationRecord

  paginates_per  2
  mount_uploader :attachment
  ratyrate_rateable 'attachment', 'content'
  is_impressionable counter_cache: true
  # after_create :set_defaults
  belongs_to :user
  has_many :comments, dependent: :destroy
  scope :is_public, -> { where(status: 'public') }
  scope :is_private, -> { where(status: 'private') }

  def increase_visit
    self.count += 1
    save!
  end
  private
  # binding.pry
  # def set_defaults
  #   self.attachment = 'ruby.png' if self.attachment.nil?
  # end
  def self.search(search)
    where('attachment LIKE ?', "%#{search}%")
    where('content LIKE ?', "%#{search}%")
  end
 end
