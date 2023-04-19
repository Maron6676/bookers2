class UsersController < ApplicationController
  def index
    @users = User.all
    @book_info = Book.new
    @user_info = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_info = Book.new
    @user_info = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
