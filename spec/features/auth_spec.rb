require 'spec_helper'

feature "Sign in and Sign Out of Work" do
  scenario "login to site" do
    parent = FactoryGirl.create(:parent_user)
    do_login(parent)
    current_path.should == parent_path(parent)
  end


  scenario "Try to access site when current season is nil", :focus => :failing do
    parent = FactoryGirl.create(:parent_user)
    Season.where(:current => true).delete_all
    do_login(parent)
    current_path.should == registration_closed_path 
  end
end
