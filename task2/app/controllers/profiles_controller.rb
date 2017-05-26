class ProfilesController < ApplicationController
  expose_decorated :user

  def show
    if User.exists?(params[:id])
      user = User.find(params[:id])
    else
      render "profiles/not_found"
    end
  end

end
