class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		redirect_to images_path
  	end
  end

  def help
  end
end
