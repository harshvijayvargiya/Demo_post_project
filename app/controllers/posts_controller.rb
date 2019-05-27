class PostsController < InheritedResources::Base

    def create
        # binding.pry
    @post = current_user.posts.create(post_params)
    @post.save
    redirect_to posts_path
    end

    

    def index
        # binding.pry
        
        @posts = current_user.posts
    end

    def all_user_post
        @posts = Post.all
    end
  private

    def post_params
      params.require(:post).permit(:attachment, :content)
    end

end
