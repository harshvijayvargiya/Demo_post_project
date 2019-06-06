# frozen_string_literal: true

namespace :custom do
  desc 'create post!'
  desc 'update post content!'
  desc 'delete all post!'

  task posts: :environment do
    #  Post.create(attachment:"forest_g.jpeg", content:"rake task", user_id:"1",status: "public")
    # post = Post.all
    # post.update_all(content:"All post content update by rake task")
    # post.delete_all
    # # Post.save
  end
end
