class UsersController < ApplicationController
  layout 'lightbox'

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new2
    @user = User.new
    respond_to do |format|
        format.html {redirect_to signup_path}
        format.js{ render 'users/replace'}
        format.json { render 'users/replace' }
    end
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Welcome to the Canvas!"
      redirect_to @user.profile
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation, :operator)
  end

end
