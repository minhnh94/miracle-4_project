class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :correct_admin,   only: [:destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    if logged_in?
      redirect_to current_user
      puts "ngoc"
    else   
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit
     @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to the GAME GEEK!"
      redirect_to @user
    else
      render 'new'
    end
  end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
        respond_to do |format|
          if @user.update(user_params)
            flash[:success] = 'User was successfully updated.'
            format.html { redirect_to @user }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy  
        @user.image.each_with_index do |image,index|
          image.image_comment.each do |comment|
            comment.destroy
          end
          image.destroy
        end
        @user.image_comment.each do |comment|
          comment.destroy
        end
        @user.destroy
        respond_to do |format|
          flash[:success] = 'User was successfully destroyed.'
          format.html { redirect_to users_url}
          format.json { head :no_content }
        end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
     # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    def correct_admin
      @user = current_user
      redirect_to(root_url) unless @user.is_admin
    end
end
