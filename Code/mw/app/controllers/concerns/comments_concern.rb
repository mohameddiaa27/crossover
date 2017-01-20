# CommentsConcern:
# A module for warpping comments common actions
module CommentsConcern
  extend ActiveSupport::Concern

  # Filters
  included do
    before_action :set_comment, except: [:index]
    before_action :validate_presence, except: [:index]
  end

  # Actions
  def index
    @comments.includes(:account).page(params[:page]).per(10)
    render json: @tickets, include: [:account], status: :ok
  end

  def destroy
    if can_delete?
      @comment.destroy
      render json: @comment, status: :ok
    else
      render json: {
        error_message: 'Comment can not be deleted !!'
      }, status: :unauthorized
    end
  end

  private

  # Error Responses
  def validate_presence
    return unless @ticket.nil?
    render json: {
      error_message: 'Comment maybe deleted'
    }, status: :not_found
  end

  def can_delete?
    @comment.account == env['warden'].user
  end
end
