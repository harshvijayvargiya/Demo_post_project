# frozen_string_literal: true

class Post < ApplicationRecord
  paginates_per  1
  mount_uploader :attachment
  ratyrate_rateable 'attachment', 'content'
  is_impressionable counter_cache: true

  after_create :set_default
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :is_public, -> { where(status: 'public') }
  scope :is_private, -> { where(status: 'private') }
  scope :Posts_order,-> { order('created_at DESC') }
  scope :current_user_private_post, -> { where('user_id = ? AND status = ?', User.current.id, 'private').order("created_at DESC") }


  def self.search(search)
    if search
      where('attachment LIKE ?', "%#{search}%")
      where('content LIKE ?', "%#{search}%")
    else
      Post.all
    end
  end

  def increase_visit
    self.count += 1
    save!
  end

  private

  def set_default
    if status == ''
      self.status = 'private'
      save!
    end
  end
end
