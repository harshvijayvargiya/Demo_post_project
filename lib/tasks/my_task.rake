namespace :custom do
  desc "update post content!"

  task posts: :environment do
    post = Post.all
    post.update_all(content:"update by rake task")
    # Post.save
  end
end