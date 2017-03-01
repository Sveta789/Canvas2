class ShootingsController < ApplicationController
  def index
    @shootings = Shooting.all
  end

  def show
  end

  def destroy
    Shooting.find(params[:id]).destroy
    redirect_to current_user.portfolio
  end

  def edit
  end

  def new
    @shooting = Shooting.new
    respond_to do |format|
      format.html {redirect_to signup_path}
      format.js{ render 'shootings/new_shooting'}
      format.json { render 'shootings/new_shooting'}
    end
  end

  def create
    @shooting = current_user.shootings.build(shooting_params)    # Not the final implementation!
    if @shooting.save
      flash[:success] = "Услуга добавлена!"
      redirect_to @shooting.user.portfolio
    else
      render 'new'
    end
  end

  def shootings_of_user
    @shootings = current_user.shootings
    render 'my_shootings'
  end

  def shooting_params
    params.require(:shooting).permit(:category, :price,
                                 :description)
  end
end
