class PostsController < InheritedResources::Base
    impressionist actions: [:show], unique: [:user_id]

    def create
        # binding.pry
        @post = current_user.posts.create(post_params)
        @post.save
        redirect_to posts_path
    end

    def show
        # binding.pry
        @post = Post.find(params[:id])
        if @post.count == 0
            @post.increase_visit    
         end
        
        if @post.count < 1
        impressionist @post
        end
        
    end
    

    def index
        # binding.pry
        @posts = current_user.posts
    end

    def all_user_post
        # binding.pry
        @posts = Post.is_public
    end
    private

    def post_params
      params.require(:post).permit(:attachment, :content, :status)
  end

end
