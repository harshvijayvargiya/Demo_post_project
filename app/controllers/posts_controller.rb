# frozen_string_literal: true

class PostsController < InheritedResources::Base
  impressionist actions: [:show], unique: [:user_id]
  # before_action :execute_this, if: :this_is_true?
  # before_action do
  #   binding.pry
  # end

  def method_name
    @post = current_user.posts.build  
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    flash[:success] = 'Post Created'
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
    @posts = current_user.posts.Posts_order # Posts_order for show latest post at top using scope
    @posts = current_user.posts.search(params[:search]) if params[:search]
  end

  def all_user_post
    # binding.pry
    if !current_user.role
      @posts = []
      @posts << Post.is_public.Posts_order
      @posts << Post.current_user_private_post # show current_user_private_post using scope
      @posts = @posts.flatten

      if params[:search]
        @posts = []
        @posts << Post.is_public.search(params[:search])
        @posts << current_user.posts.is_private.search(params[:search])
        @posts = @posts.flatten
      end

    else
      @posts = Post.all.Posts_order # Posts_order for show latest post at top using scope
      @posts = Post.search(params[:search]) if params[:search]
    end
  end

  def posts_by_status
    @posts = if params[:status] == 'public'
               current_user.posts.is_public.Posts_order # Posts_order for show latest post at top using scope
             elsif params[:status] == 'private'
               Post.current_user_private_post # show current_user_private_post using scope
             else
               current_user.posts.Posts_order # Posts_order for show latest post at top using scope
              end
  end

  def all_posts_by_status
    @posts = if params[:status] == 'public'
               Post.is_public.Posts_order # Posts_order for show latest post at top
             elsif params[:status] == 'private' && current_user.role == 'admin'
               Post.is_private.Posts_order # Posts_order for show latest post at top using scope
             else
               Post.current_user_private_post # show current_user_private_post using scope
              end
  end

  def destroy_multiple
    # binding.pry
    Post.destroy(params[:post_id])

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.json { head :no_content }
    end
  end

  private

  # def this_is_true?
  #   # binding.pry
  #   Rails.logger.debug "This is being executed before #{params[:action]}"
  #   true
  # end

  def post_params
    params.require(:post).permit(:attachment, :content, :status)
  end
end
