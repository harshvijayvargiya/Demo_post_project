# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def index
    @comments = @post.comments.order(created_at: :desc)
  end

  def create
    @post = Post.find(params[:post_id])
    parent = Comment.find_by_id(params[:comment].delete(:parent_id))
    @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)

    #   @comment = @post.comments.find(params[:id])

    #   if @comment.user_id == @current_user_id
    #     @comment.destroy
    #     render json: {}
    #   else
    #     render json: { errors: { comment: ['not owned by user'] } }, status: :forbidden
    # end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
end
end
