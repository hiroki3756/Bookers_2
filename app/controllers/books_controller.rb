class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,{only:[:edit]}
    
    def index
        @books = Book.all
        @book = Book.new
        @user = User.find(current_user.id)
        @users = User.all
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
          flash[:notice] = "Book was successfully created."
          redirect_to book_path(@book)
        else
          @books = Book.all
          @user = User.find(current_user.id)
          render :index
        end
      end

      def show
        @book = Book.new
        @booked = Book.find(params[:id])
        @user = @booked.user
      end

      def edit
        @book = Book.find(params[:id])
      end
    
      def update
        @book = Book.find(params[:id])
        @book.update(book_params)
        if @book.save
          flash[:notice] ="Book was successfully updated."
        redirect_to book_path(@book)
        else
          
          render :edit
        end
      end

      def destroy
        book = Book.find(params[:id])
        book.destroy
        flash[:notice] = "Book was succesfully destroyed."
        redirect_to books_path
      end

      def ensure_correct_user
        @book = Book.find(params[:id])
        if @book.user_id != current_user.id
            redirect_to books_path
        end
    end

      private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
