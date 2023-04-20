class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user_info = User.find(current_user.id)
      @book_info = @book
      render :index
    end
  end

  def index
    @books = Book.all
    @book_info = Book.new
    @user_info = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @book_info = Book.new
    @user_info = @book.user
  end

  def edit
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
    @book = Book.find(params[:id])

  end

  def update
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end

    if book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(book.id)
    else
      @book = book
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
