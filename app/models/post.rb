class Post < ApplicationRecord
   belongs_to :user  
   mount_uploader :attachment
   ratyrate_rateable 'attachment', 'content'

end
