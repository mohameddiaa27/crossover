# CommentsConcern:
# A module for warpping comments common actions
module CommentsConcern
  extend ActiveSupport::Concern

  # Filters
  included do
    before_action :set_comment, except: [:index, :create]
  end

  # Actions
  # def index
  #   @comments.includes(:account).page(params[:page]).per(10)
  #   render json: @tickets, include: [:account], status: :ok
  # end

  def create
    @comment           = Comment.new(comment_params)
    @comment.account   = current_user
    if @comment.save
      render json: @comment, include: :account, status: :ok
    else
      render json: {
        error_message: 'Comment can not be created !!'
      }, status: :bad_request
    end
  end

  def destroy
    if can_delete?
      p @comment.destroy!
      render json: @comment, status: :ok
    else
      render json: {
        error_message: 'Comment can not be deleted !!'
      }, status: :unauthorized
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    if @comment.nil?
      render json: {
        error_message: 'Comment not found'
      }, status: :not_found
    end
  end

  def can_delete?
    @comment.account == current_user
  end

  def comment_params
    params.fetch(:comment, {}).permit(:body, :ticket_id)
  end
end
