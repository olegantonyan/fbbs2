class UsersController < BaseAdminController
  before_filter :set_user, only: [:show, :edit, :update, :destroy, :approve, :update_profile]
  skip_before_filter :check_user_admin, only: [:profile, :update_profile]
  
  # GET /users/profile
  def profile
    @user = current_user
  end
  
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  #def new
  #  @user = User.new
  #end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  #def create
  #  @user = User.new(user_params)
  #  if @user.save
  #    redirect_to @user, notice: 'User was successfully created.'
  #  else
  #    render action: "new"
  #  end
  #end
  
  def approve
    if @user.approved
      redirect_to @user, notice: 'User is already approved.'
      return
    end 
    @user.approved = true
    if @user.save
      redirect_to @user, notice: 'User was successfully approved.'
    else
      render action: "edit", flash: {error: 'Error approving user.'}
    end
  end

  # PUT /users/1
  def update
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def update_profile
    # warning! this action may be called by any user
    if @user.update_attributes(user_params_profile)
      if current_user == @user
        redirect_to user_root_path, notice: 'Your profile was successfully updated.'
      else
        redirect_to @user, notice: 'User profile was successfully updated.'
      end
    else
      render action: "profile"
    end
  end
  
  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: "User #{@user.email} was successfully deleted."
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:admin, :approved, :background_image, :background_image_opacity, :remove_background_image)
  end
  
  def user_params_profile
    params.require(:user).permit(:background_image, :background_image_opacity, :remove_background_image)
  end
  
end
