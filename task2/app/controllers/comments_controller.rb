class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :show]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = @event.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @event
    else
      render :new
    end

  end

  def edit
  end

  def update
  end

  def destroy
    @comment.destroy
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
