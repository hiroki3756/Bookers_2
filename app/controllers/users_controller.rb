class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user,{only:[:edit]}
  def top
    @user = current_user
    @book = Book.new
  end

  def index
    @book = Book.new
    @users = User.all
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] ="You have updated user successfully."
      redirect_to  user_path(@user)
      else
        render :'users/edit'
      end
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      if @user.id != current_user.id
          redirect_to user_path(current_user.id)
      end
  end
  
    private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
