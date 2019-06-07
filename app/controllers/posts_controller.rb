# frozen_string_literal: true

class PostsController < InheritedResources::Base
  impressionist actions: [:show], unique: [:user_id]

  def create
    @post = current_user.posts.create(post_params)
    @post.save
    redirect_to posts_path
  end

  def show
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
    @posts = current_user.posts.order('attachment')
    @posts = Post.search(params[:search]) if params[:search]
  end

  def all_user_post
    if user_signed_in? && current_user.role == 'admin'
      @posts = Post.all
    else
      @posts = Post.is_public.order('attachment')
      @posts = Post.search(params[:search]) if params[:search]
    end
  end

  private

  def post_params
    params.require(:post).permit(:attachment, :content, :status)
  end
end
