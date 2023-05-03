class FavoritesController < ApplicationController
  def index
    @book = Book.all
  end

  def create
    Favorite.create(user_id: current_user.id, book_id: params[:id])
    redirect_to books_path
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
    redirect_to books_path
  end
end
