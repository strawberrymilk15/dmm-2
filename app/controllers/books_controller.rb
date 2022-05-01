class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index,:show]
  before_action :ensure_correct_user, only: [:edit,:update,:destroy]

  def show
    @book = Book.find(params[:id])
    unless Browsing.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.browsings.create(book_id: @book.id)
    end
    @user = @book.user
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def index
    @books = Book.left_joins(:week_favorites).group(:id).order(Arel.sql('count(book_id) desc'))
    @book = Book.new
    @new_book = Book.new
    @user = User.find_by(id: current_user.id)
  end
  

  def create
    @book = Book.new(book_params)
    @user = @book.user
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to book_path(book.id), notice: "You have updated book successfully."
    else
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,:body).merge(user_id: current_user.id)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to root_path
    end
  end
end
