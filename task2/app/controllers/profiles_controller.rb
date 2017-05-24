class ProfilesController < ApplicationController
  expose_decorated :user

  def show
    user = User.find(params[:id])
  end

end
