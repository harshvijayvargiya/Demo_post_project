# frozen_string_literal: true

class PostsController < InheritedResources::Base
  impressionist actions: [:show], unique: [:user_id]

  def create
    @post = current_user.posts.create(post_params)
    # TODO: handle validation errors
    @post.save
    flash[:success] = "Post Created"
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
    if current_user.role != 'admin'
      @posts = []
      @posts << Post.is_public.order('attachment')
      @posts <<  Post.where('user_id = ? AND status = ?', current_user.id, 'private')
      # @posts << current_user.posts.is_private.order('attachment')
      @posts = @posts.flatten
      @posts = Post.search(params[:search]) if params[:search]
    else
      @posts = Post.all
      @posts = Post.search(params[:search]) if params[:search]
    end
  end

  def posts_by_status
    #binding.pry
    @posts = if params[:status] == 'public'
                 current_user.posts.is_public
               elsif params[:status] == 'private'
                 Post.where('user_id = ? AND status = ?', current_user.id, 'private')
               else
                 current_user.posts
               end
  end

  def all_posts_by_status
    @posts = if params[:status] == 'public'
                 Post.is_public
                elsif params[:status] == 'private' && current_user.role == 'admin'
                 Post.is_private
                else
                 Post.where('user_id = ? AND status = ?', current_user.id, 'private')
               end
  end

  private

  def post_params
    params.require(:post).permit(:attachment, :content, :status)
  end
end
