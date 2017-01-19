class Ng::V1::Admin::CommentsController < ApplicationController

  # Include
  include CommentsConcern

	private
  def can_delete?
    true
  end
end
