class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    flash.now[:notice] = 'コメントを投稿しました'
    render :book_comment
  end

  def destroy
    BookComment.find(params[:id]).destroy
    flash.now[:alert] = 'コメントを削除しました'
    book = Book.find(params[:book_id])
    render :book_comment

  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
