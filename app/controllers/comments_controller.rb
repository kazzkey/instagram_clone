class CommentsController < ApplicationController
  def create
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to picture_path(params[:picture_id]), notice: 'コメントしました！'
    else
      redirect_to picture_path(params[:picture_id]), notice: 'コメントに失敗しました'
    end
  end
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
     redirect_to pictures_path
  end
  private
  def comment_params
    params.require(:comment).permit(:content, :picture_id, :user_id)
  end
end
