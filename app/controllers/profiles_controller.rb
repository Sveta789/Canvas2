class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def edit_avatar
    @profile = Profile.find(params[:id])
    if current_user.id == @profile.user_id
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render 'profiles/edit_avatar' }
        format.json { render 'profiles/edit_avatar' }
      end
    end
  end


  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
        redirect_to @profile
    else
      render 'edit'
    end
  end

  def update_avatar
    @profile = Profile.find(profile_params[:id])
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to @profile.user.portfolio
    else
      render 'edit'
    end
  end

  def destroy
  end

  def profile_params
    params.require(:profile).permit!
  end
end
