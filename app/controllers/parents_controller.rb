class ParentsController < InheritedResources::Base
  def show
    @parent = current_user.profileable
  end

  def edit
    @parent = Parent.find(params[:id])
    @demographic = @parent.current_household_profile || @parent.demographics.build
  end

  def update
    update!{
      @demographic = @parent.current_household_profile
      dashboard_path
    }
  end
end

