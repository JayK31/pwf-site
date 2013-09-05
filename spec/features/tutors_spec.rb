require 'spec_helper'

feature "tutor behavior",:js=>true , :focus => :tut do
  let(:tutor){FactoryGirl.create(:tutor)}
  let!(:aep_reg){FactoryGirl.create(:complete_aep_registration)}
  let(:student){aep_reg.student}
  let(:assignment){FactoryGirl.create(:tutoring_assignment, :tutor => tutor, :aep_registration => aep_reg)}
  context "session reports" do
    context "require login" do
      let!(:rep){FactoryGirl.create(:valid_session_report, :tutor => tutor, :aep_registration => aep_reg)}
      before do
        do_login(tutor.user)
      end
      context "New report"  do
        scenario "create a new valid session report" do
          click_link "Create new session report"
          fill_in_session_form
          pick_date
          click_button "Save"
          assert_report_saved
        end

        scenario "invalid session report" do
          click_link "Create new session report"
          fill_in_session_form
          click_button "Save"
          assert_errors
        end
      end

      context "existing session report" do
        context "unconfirmed" do
          scenario "confirm session report" do
            find_and_confirm_report "Session"
            accept_popup
            assert_report_finalized
          end

          scenario "Cancels confirm report" do
            find_and_confirm_report "Session"
            cancel_popup
            page.should_not have_content "Report Confirmed and Finalized"
          end
        end
      end
    end
    context "confirmed" do
      scenario "edit redirects to finalized report" do
        rep = FactoryGirl.create(:confirmed_session_report, :tutor => tutor, :aep_registration => aep_reg)
        do_login(tutor.user)
        click_link "Session Reports"
        click_link rep.student_name
        current_path.should == session_report_path(rep)
      end
    end
  end

  context "monthly reports"  do
    context "New report"  do
      before do
        do_login(tutor.user)
      end

      scenario "create a new valid monthly report" do
        click_link "Create new monthly report"
        fill_in_monthly_form
        click_button "Save"
        assert_report_saved
      end

      scenario "invalid monthly report" do
        click_link "Create new monthly report"
        fill_in_monthly_form
        fill_in "Progress notes", :with => "" 
        click_button "Save"
      end
    end

    context "when existing monthly report" do
      context "is unconfirmed" do
        let!(:rep){FactoryGirl.create(:valid_monthly_report, :tutor => tutor, :aep_registration => aep_reg)}
        before do
          do_login(tutor.user)
        end
        scenario "confirm monthly report" do
          find_and_confirm_report "Monthly"
          accept_popup
          assert_report_finalized
        end

        scenario "Cancels confirm report" do
          find_and_confirm_report "Monthly"
          cancel_popup
          page.should_not have_content "Report Confirmed and Finalized"
        end

      end
      context "when confirmed" do
        scenario "edit redirects to finalized report" do
          rep = FactoryGirl.create(:confirmed_monthly_report, :tutor => tutor, :aep_registration => aep_reg)
          do_login(tutor.user)
          click_link "Monthly Reports"
          click_link rep.student_name
          current_path.should == monthly_report_path(rep)
        end
      end
    end
  end

  context "Year End reports"  do
    context "New report"  do
      before do
        do_login(tutor.user)
      end

      scenario "create a new valid year end report" do
        click_link "Create new year end report"
        fill_in_year_end_form
        click_button "Save"
        assert_report_saved
      end

      scenario "invalid year end report" do
        click_link "Create new year end report"
        fill_in_year_end_form
        fill_in "Attendance", :with => "" 
        click_button "Save"
      end
    end

    context "when existing year end report" do
      context "is unconfirmed" do
        let!(:rep){FactoryGirl.create(:valid_year_end_report, :tutor => tutor, :aep_registration => aep_reg)}
        before do
          do_login(tutor.user)
        end
        scenario "confirm year end report" do
          find_and_confirm_report "Year End"
          accept_popup
          assert_report_finalized
        end

        scenario "Cancels confirm report" do
          find_and_confirm_report "Year End"
          cancel_popup
          page.should_not have_content "Report Confirmed and Finalized"
        end

      end
      context "when confirmed" do
        scenario "edit redirects to finalized report" do
          rep = FactoryGirl.create(:confirmed_year_end_report, :tutor => tutor, :aep_registration => aep_reg)
          do_login(tutor.user)
          click_link "Year End Reports"
          click_link rep.student_name
          current_path.should == year_end_report_path(rep)
        end
      end
    end
  end


  def find_and_confirm_report type
    click_link "#{type} Reports"
    click_link rep.student_name
    check "Finalize and Confirm?"
    click_button "Save"
  end

  def pick_date
    page.execute_script('$("input.datepicker").trigger("focus")')
    page.execute_script('$("td.day:contains(15)").trigger("click")')
  end

  def fill_in_session_form
    select student.name, :from => "Student"
    select "Homework assistance", :from =>"Worked on"
    select "Well prepared", :from =>"Preparation"
    select "Excellent", :from =>"Participation"
    select "Excellent", :from =>"Comprehension"
    select "Excellent", :from =>"Motivation"
  end


  def fill_in_monthly_form
    select student.name, :from => "Student"
    select "October", :from => "Month"
    fill_in "Num hours with student", :with => 10
    fill_in "Num preparation hours", :with => 10
    fill_in "Student goals", :with => "blah blah"
    choose "monthly_report_goals_achieved_false"
    fill_in "Progress notes", :with => "blah blah" 
    choose "monthly_report_new_goals_set_false"
    fill_in "New goals desc", :with => "Something Else"
    fill_in "Issues concerns", :with => "He Cray Cray"
    fill_in "Issues resolution", :with =>",Lock him up"
  end

  def fill_in_year_end_form
    select student.name, :from => "Student"
    fill_in "Attendance", :with =>"blah" 
    fill_in "Preparation", :with => "blase blase" 
    fill_in "Participation", :with => "blah blah"
    fill_in "Academic skills", :with => "blah blah" 
    fill_in "Challenges concerns", :with => "Something Else"
    fill_in "Achievements", :with => "He Cray Cray"
    fill_in "Recommendations", :with =>",Lock him up"
    fill_in "Comments", :with =>"Lock him up"
  end

  def assert_report_saved
    page.should have_content "Report successfully saved"
  end

  def assert_errors
    page.should have_content "Please review the problems below"
  end

  def assert_report_finalized
    page.should have_content "Report Confirmed and Finalized"
  end

end

