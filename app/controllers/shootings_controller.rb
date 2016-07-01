class ShootingsController < ApplicationController
  def index
    @shootings = Shooting.all
  end

  def show
  end

  def destroy
  end

  def edit
  end

  def new
    @shooting = Shooting.new
  end

  def create
    @shooting = current_user.shootings.build(shooting_params)    # Not the final implementation!
    if @shooting.save
      flash[:success] = "Услуга добавлена!"
      redirect_to :back
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
                                 :description, :image)
  end
end
