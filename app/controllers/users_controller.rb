class UsersController < InheritedResources::Base
  def show
    @user = current_user
  end

  def edit
    @user =current_user
  end

end

