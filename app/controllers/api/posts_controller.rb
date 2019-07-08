# frozen_string_literal: true

class Api::PostsController < ApplicationController
  impressionist actions: [:show], unique: [:user_id]

  def create
    post = current_user.posts.create(post_params)
    post.save
    render json: post
    redirect_to posts_path
  end

  def show
    post = Post.find(params[:id])
    post.increase_visit if post.count == 0
    impressionist post if post.count
    render json: post
  end

  def download_file
    post = Post.find(params[:format])
    send_file(post.attachment.path,
              filename: post.attachment,
              type: post.attachment.content_type,
              disposition: 'attachment',
              url_based_filename: true)
    render json: post
  end

  def index
    posts = current_user.posts.order('created_at DESC')
    posts = current_user.posts.search(params[:search]) if params[:search]
    render json: posts
  end

  def all_user_post
    posts = Post.all
    render json: posts
  end

  def posts_by_status
    posts = if params[:status] == 'public'
              current_user.posts.is_public.order('created_at DESC')
              render json: posts
            elsif params[:status] == 'private'
              Post.where('user_id = ? AND status = ?', current_user.id, 'private').order('created_at DESC')
              render json: posts
            else
              current_user.posts.order('created_at DESC')
              render json: posts
              end
  end

  def all_posts_by_status
    posts = if params[:status] == 'public'
              Post.is_public.order('created_at DESC')
              render json: posts
            elsif params[:status] == 'private' && current_user.role == 'admin'
              Post.is_private.order('created_at DESC')
              render json: posts
            else
              Post.where('user_id = ? AND status = ?', current_user.id, 'private').order('created_at DESC')
              render json: posts
              end
  end

  def destroy_multiple
    Post.destroy(params[:post_id])

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.json { head :no_content }
      render json: posts
    end
    end

  private

  def post_params
    params.require(:post).permit(:attachment, :content, :status)
  end
end
