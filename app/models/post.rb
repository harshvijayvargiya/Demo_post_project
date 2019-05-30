class Post < ApplicationRecord
   belongs_to :user  
   mount_uploader :attachment
   ratyrate_rateable 'attachment', 'content'
   is_impressionable counter_cache: true

   scope :is_public, -> { where(status: 'public') }
   scope :is_private, -> { where(status: 'private') }

   # enum :select_value { is_public: true,  is_private: false}
end
