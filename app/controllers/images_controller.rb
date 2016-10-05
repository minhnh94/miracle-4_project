class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy, :search]
  before_action :require_login, only: [:edit, :update, :destroy, :new, :create]
  before_action :correct_user,   only: [:edit,:destroy]
  # GET /images
  # GET /images.json
  def index
      @images = Image.all
      if params[:search]
         @images = Image.search(params[:search]).order(created_at: :desc)
      else
        @images = Image.all.order(created_at: :desc)
      end
  end
  def search
      if params[:search]
         @images = Image.search(params[:search])
      else
        @images = Image.all
      end
  end
  # GET /images/1
  # GET /images/1.json
  def show
    @image_comment = ImageComment.new
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.user_id = current_user.id
    respond_to do |format|
      if @image.save
        flash[:success]='Image was successfully created.';
        format.html { redirect_to images_url}
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end


  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      flash[:success]='Image was successfully destroyed.'
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:user_id, :title, :file, :created_at)
    end

    def require_login
      unless logged_in?
        flash[:danger] = "You must be logged in to access this section"
        redirect_to login_path
      end
    end
    def correct_user
      redirect_to images_url unless @image.user == current_user
    end
end
