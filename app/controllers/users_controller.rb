class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :show]
  before_filter :correct_user,   only: [:edit, :update, :show]


  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def edit
  end

  def index
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Moomint BDBC!"
      redirect_to @user
    else
      render 'new'
    end
  end


  private

  def signed_in_user
    redirect_to signin_url, notice: "#JoinTheMooMint" unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
