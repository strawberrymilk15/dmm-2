class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    book_favorite = @book.favorites.new(user_id: current_user.id)
    if book_favorite.save
      redirect_to request.referer
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_favorite = @book.favorites.find_by(user_id: current_user.id)
    book_favorite.destroy
    redirect_to request.referer
  end
end
