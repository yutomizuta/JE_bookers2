class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :set_q, only: [:index, :search]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    if params[:tag_name]
      @books = Book.tagged_with("#{params[:tag_name]}")
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  def search
    @results = @q.result
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :tag_list)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def set_q
    @q = Book.ransack(params[:q])
  end
end
