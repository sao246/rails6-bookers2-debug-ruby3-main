class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id

    if @book_comment.save
      redirect_to book_path(@book), notice: "コメントを投稿しました"
    else
      render "books/show"
    end

  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def is_matching_login_comment
    book_comment = BookComment.find(params[:id])
    unless book_comment.user.id == current_user.id
      redirect_to books_path
    end
  end
end
