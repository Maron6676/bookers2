class FavoritesController < ApplicationController
  before_action :book_params

  def index
    @book = Book.all
  end

  def create
    Favorite.create(user_id: current_user.id, book_id: params[:id])
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
  end

  private

  def book_params
    @book = Book.find(params[:id])
  end
end
