# frozen_string_literal: true

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
    # TODO
    @post.increase_visit if @post.count == 0
    impressionist @post if @post.count
  end

  def download_file
    @post = Post.find(params[:format])
    send_file(@post.attachment.path,
              filename: @post.attachment,
              type: @post.attachment.content_type,
              disposition: 'attachment',
              url_based_filename: true)
  end

  def index
    # binding.pry
    @posts = current_user.posts.order('attachment')
    @posts = Post.search(params[:search]) if params[:search]
  end

  def all_user_post
    if current_user.role != 'admin'
      @posts = []
      @posts << Post.is_public.order('attachment')
      @posts <<  Post.where('user_id = ? AND status = ?', current_user.id, 'private')
      @posts = @posts.flatten
    else
      @posts = Post.all
      # @postss = current_user.posts.is_private.order('attachment')
    end 
  end

  private

  def post_params
    params.require(:post).permit(:attachment, :content, :status)
  end
end
