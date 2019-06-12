# frozen_string_literal: true

class PostsController < InheritedResources::Base
  impressionist actions: [:show], unique: [:user_id]

  def create
    @post = current_user.posts.create(post_params)
    @post.save
    flash[:success] = "Post Created"
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
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
    @posts = current_user.posts.order('created_at DESC')
    @posts = current_user.posts.search(params[:search]) if params[:search]
  end

  def all_user_post
    if current_user.role != 'admin'
      @posts = []
      @posts << Post.is_public.order('attachment')
      @posts <<  Post.where('user_id = ? AND status = ?', current_user.id, 'private')
      @posts = @posts.flatten

      if params[:search]
        @posts = []
        @posts << Post.is_public.search(params[:search])
        @posts << current_user.posts.is_private.search(params[:search])
        @posts = @posts.flatten
      end 

    else
      @posts = Post.all.order('created_at DESC')
      if params[:search]
        @posts = Post.search(params[:search]) 
      end
    end
  end

  def posts_by_status
    @posts = if params[:status] == 'public'
                 current_user.posts.is_public.order('created_at DESC')
               elsif params[:status] == 'private'
                 Post.where('user_id = ? AND status = ?', current_user.id, 'private').order('created_at DESC')
               else
                 current_user.posts.order('created_at DESC')
              end
  end

  def all_posts_by_status
    @posts = if params[:status] == 'public'
                 Post.is_public.order('created_at DESC')
                elsif params[:status] == 'private' && current_user.role == 'admin'
                 Post.is_private.order('created_at DESC')
                else
                 Post.where('user_id = ? AND status = ?', current_user.id, 'private').order('created_at DESC')
              end
  end

  def destroy_multiple
    binding.pry
    Post.destroy(params[:post_ids])

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.json { head :no_content }
    end

  end

  private

  def post_params
    params.require(:post).permit(:attachment, :content, :status)
  end
end
