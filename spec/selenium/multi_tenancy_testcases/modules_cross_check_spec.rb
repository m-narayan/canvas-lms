require File.expand_path(File.dirname(__FILE__) + '/common_mt')
require File.expand_path(File.dirname(__FILE__) + '/module_data_setup')

describe "Module_cross_checking_test" do

  it_should_behave_like "in-process server selenium tests"

  def viewing_modules(params={})
    driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}"
    fill_in_login_form(params[:user_name],"Admin123$")
    wait_for_ajaximations
    f('.user_name').text.should == params[:user_name]
    params[:modules].each do |module_details|
      course_obj=Course.find(module_details.context)
      module_item=ContentTag.find_by_context_module_id(module_details.id)
      assignment_obj=Assignment.find(module_item.content_id)
      driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/courses/#{course_obj.id}/modules"
      wait_for_ajaximations
      f("#section-tabs-header").text.should include_text course_obj.course_code
      f("#breadcrumbs").text.should include_text "Modules"
      f(".context-modules-main-header").text.should include_text "Course Modules"
      f("#context_modules").text.should include_text module_details.name
      f("#context_modules").text.should include_text module_item.title
      if params[:user_role]!="Student"
        f('.add_module_link').text.should include_text "Create a Module"
        f('.module_progressions_link').text.should include_text "View Progress"
      end
      driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/courses/#{course_obj.id}/assignments/#{module_item.content_id}?module_item_id=#{module_item.id}"
      wait_for_ajaximations

      if params[:user_role]=="Student"
        f('#breadcrumbs').text.should include_text module_item.title
        f('#content').text.should include_text module_item.title
      else
        f('.edit_assignment_link').should be_displayed
        f('.title-content').text.should include_text module_item.title
        f('.description').text.should include_text assignment_obj.description
      end
    end
    driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}"
    wait_for_ajaximations
    expect_new_page_load { f('.logout > a').click }

  end

  def cross_check_with_modules(params={})
    driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}"
    fill_in_login_form(params[:user_name],"Admin123$")
    wait_for_ajaximations
    f('.user_name').text.should == params[:user_name]

    if params[:checking_type]=="view all modules"
      params[:courses].each do |course|
        if  params[:access_type]=="Change course id"
          driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/courses/#{course.id}/modules"
          unauthorized_warning_message
        elsif  params[:access_type]=="Change course url"
          driver.get "http://#{params[:checking_account_name]}.lvh.me:#{$server_port}/courses/#{course.id}/modules"
          login_warning_message
        end
      end
    elsif params[:checking_type]=="view modules one by one"
      params[:modules].each do |module_details|
        course_obj=Course.find(module_details.context)
        module_item=ContentTag.find_by_context_module_id(module_details.id)
        if params[:access_type]=="Change module id"
          driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/courses/#{course_obj.id}/assignments/#{module_item.content_id}?module_item_id=#{module_item.id}"
          unauthorized_warning_message
        elsif params[:access_type]=="Change module url"
          driver.get "http://#{params[:checking_account_name]}.lvh.me:#{$server_port}/courses/#{course_obj.id}/assignments/#{module_item.content_id}?module_item_id=#{module_item.id}"
          login_warning_message
        end
      end
      driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}"
      wait_for_ajaximations
      expect_new_page_load { f('.logout > a').click }
    end



  end

  ###### IBM Admin viewing its course modules
  it "should show all the course modules when an admin logged into ibm domain" do
    viewing_modules(:account_name=>"ibm",:user_name=>"ibm@arrivusystems.com",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:module_contents=>[ibm_course1_module1_assignment,ibm_course1_module2_assignment,ibm_course2_module1_assignment,ibm_course2_module2_assignment,ibm_course3_module1_assignment,ibm_course3_module2_assignment],:user_role=>"Admin")
  end

  ###### TCS Admin viewing its course modules
  it "should show all the course modules when an admin logged into tcs domain" do
    viewing_modules(:account_name=>"tcs",:user_name=>"tcs@arrivusystems.com",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module2,tcs_course3_module2],:module_contents=>[tcs_course1_module1_assignment,tcs_course1_module2_assignment,tcs_course2_module1_assignment,tcs_course2_module2_assignment,tcs_course3_module1_assignment,tcs_course3_module2_assignment],:user_role=>"Admin")
  end

  ##### IBM teachers viewing their course modules

  it "should show the module page when an ibm teachers logged into ibm domain" do
    viewing_modules(:account_name=>"ibm",:user_name=>"ibm.tr1@arrivusystems.com",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module2,ibm_course2_module2],:module_contents=>[ibm_course1_module1_assignment,ibm_course1_module2_assignment,ibm_course2_module1_assignment,ibm_course2_module2_assignment],:user_role=>"Teacher")
    viewing_modules(:account_name=>"ibm",:user_name=>"ibm.tr2@arrivusystems.com",:modules=>[ibm_course3_module1,ibm_course3_module2,ibm_course2_module2,ibm_course2_module2],:module_contents=>[ibm_course3_module1_assignment,ibm_course3_module2_assignment,ibm_course2_module1_assignment,ibm_course2_module2_assignment],:user_role=>"Teacher")
    viewing_modules(:account_name=>"ibm",:user_name=>"ibm.tr3@arrivusystems.com",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course3_module2,ibm_course3_module2],:module_contents=>[ibm_course1_module1_assignment,ibm_course1_module2_assignment,ibm_course3_module1_assignment,ibm_course3_module2_assignment],:user_role=>"Teacher")
  end

  ###### TCS teachers viewing their course modules

  it "should show the module page when an tcs teachers logged into tcs domain" do
    viewing_modules(:account_name=>"tcs",:user_name=>"tcs.tr1@arrivusystems.com",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module2,tcs_course2_module2],:module_contents=>[tcs_course1_module1_assignment,tcs_course1_module2_assignment,tcs_course2_module1_assignment,tcs_course2_module2_assignment],:user_role=>"Teacher")
    viewing_modules(:account_name=>"tcs",:user_name=>"tcs.tr2@arrivusystems.com",:modules=>[tcs_course3_module1,tcs_course3_module2,tcs_course2_module2,tcs_course2_module2],:module_contents=>[tcs_course3_module1_assignment,tcs_course3_module2_assignment,tcs_course2_module1_assignment,tcs_course2_module2_assignment],:user_role=>"Teacher")
    viewing_modules(:account_name=>"tcs",:user_name=>"tcs.tr3@arrivusystems.com",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course3_module2,tcs_course3_module2],:module_contents=>[tcs_course1_module1_assignment,tcs_course1_module2_assignment,tcs_course3_module1_assignment,tcs_course3_module2_assignment],:user_role=>"Teacher")
  end

  #### IBM Students viewing their course modules

  it "should show the module page when an ibm students logged into ibm domain" do
    viewing_modules(:account_name=>"ibm",:user_name=>"ibm.st1@arrivusystems.com",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module2,ibm_course2_module2],:module_contents=>[ibm_course1_module1_assignment,ibm_course1_module2_assignment,ibm_course2_module1_assignment,ibm_course2_module2_assignment],:user_role=>"Student")
    viewing_modules(:account_name=>"ibm",:user_name=>"ibm.st2@arrivusystems.com",:modules=>[ibm_course3_module1,ibm_course3_module2,ibm_course2_module2,ibm_course2_module2],:module_contents=>[ibm_course3_module1_assignment,ibm_course3_module2_assignment,ibm_course2_module1_assignment,ibm_course2_module2_assignment],:user_role=>"Student")
    viewing_modules(:account_name=>"ibm",:user_name=>"ibm.st3@arrivusystems.com",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course3_module2,ibm_course3_module2],:module_contents=>[ibm_course1_module1_assignment,ibm_course1_module2_assignment,ibm_course3_module1_assignment,ibm_course3_module2_assignment],:user_role=>"Student")
  end

  ###### TCS Students viewing their course modules

  it "should show the module page when an tcs students logged into tcs domain" do
    viewing_modules(:account_name=>"tcs",:user_name=>"tcs.st1@arrivusystems.com",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module2,tcs_course2_module2],:module_contents=>[tcs_course1_module1_assignment,tcs_course1_module2_assignment,tcs_course2_module1_assignment,tcs_course2_module2_assignment],:user_role=>"Student")
    viewing_modules(:account_name=>"tcs",:user_name=>"tcs.st2@arrivusystems.com",:modules=>[tcs_course3_module1,tcs_course3_module2,tcs_course2_module2,tcs_course2_module2],:module_contents=>[tcs_course3_module1_assignment,tcs_course3_module2_assignment,tcs_course2_module1_assignment,tcs_course2_module2_assignment],:user_role=>"Student")
    viewing_modules(:account_name=>"tcs",:user_name=>"tcs.st3@arrivusystems.com",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course3_module2,tcs_course3_module2],:module_contents=>[tcs_course1_module1_assignment,tcs_course1_module2_assignment,tcs_course3_module1_assignment,tcs_course3_module2_assignment],:user_role=>"Student")
  end

  ######## Cross testing ###############################

  ##### Ibm admin going to view Tcs domain modules by giving course id

  it "should show unauthorized message when Ibm admin try to view  Tcs course modules list  by using its course id" do
    cross_check_with_modules(:user_name=>"ibm@arrivusystems.com",:account_name=>"ibm",:courses=>[tcs_course1,tcs_course2,tcs_course3],:checking_type=>"view all modules",:access_type=>"Change course id")
  end

  it "should show unauthorized message when Ibm admin try to view  Tcs course modules list  by using its course url" do
    cross_check_with_modules(:user_name=>"ibm@arrivusystems.com",:account_name=>"ibm",:checking_account_name=>"tcs",:courses=>[tcs_course1,tcs_course2,tcs_course3],:checking_type=>"view all modules",:access_type=>"Change course url")
  end

  it "should show unauthorized message when Ibm admin try to access Tcs course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"ibm@arrivusystems.com",:account_name=>"ibm",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end

  it "should show unauthorized message when Ibm admin try to access Tcs course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"ibm@arrivusystems.com",:account_name=>"ibm",:checking_account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
  end


  ##### TCS admin going to view Ibm domain modules by giving course id

  it "should show unauthorized message when Tcs admin try to view  Ibm course modules list  by using its course id" do
    cross_check_with_modules(:user_name=>"tcs@arrivusystems.com",:account_name=>"tcs",:courses=>[ibm_course1,ibm_course2,ibm_course3],:checking_type=>"view all modules",:access_type=>"Change course id")
  end

  it "should show unauthorized message when Tcs admin try to view  Ibm course modules list  by using its course url" do
    cross_check_with_modules(:user_name=>"tcs@arrivusystems.com",:account_name=>"tcs",:checking_account_name=>"ibm",:courses=>[ibm_course1,ibm_course2,ibm_course3],:checking_type=>"view all modules",:access_type=>"Change course url")
  end

  it "should show unauthorized message when Tcs admin try to access Ibm course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"tcs@arrivusystems.com",:account_name=>"tcs",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end

  it "should show unauthorized message when Tcs admin try to access Ibm course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"tcs@arrivusystems.com",:account_name=>"tcs",:checking_account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
  end



  #### Ibm teachers going to view Tcs domain modules by giving course id


  it "should show unauthorized message when Ibm teachers try to access Tcs course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"ibm.tr1@arrivusystems.com",:account_name=>"ibm",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"ibm.tr2@arrivusystems.com",:account_name=>"ibm",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"ibm.tr3@arrivusystems.com",:account_name=>"ibm",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end

  it "should show unauthorized message when Ibm teachers try to access Tcs course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"ibm.tr1@arrivusystems.com",:account_name=>"ibm",:checking_account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
    cross_check_with_modules(:user_name=>"ibm.tr2@arrivusystems.com",:account_name=>"ibm",:checking_account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
    cross_check_with_modules(:user_name=>"ibm.tr3@arrivusystems.com",:account_name=>"ibm",:checking_account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
  end



  ###### TCS Teachers going to view Ibm domain modules by giving course id

  it "should show unauthorized message when Tcs teachers try to access Ibm course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"tcs.tr1@arrivusystems.com",:account_name=>"tcs",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"tcs.tr2@arrivusystems.com",:account_name=>"tcs",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"tcs.tr3@arrivusystems.com",:account_name=>"tcs",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end

  it "should show unauthorized message when Tcs teachers try to access Ibm course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"tcs.tr1@arrivusystems.com",:account_name=>"tcs",:checking_account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
    cross_check_with_modules(:user_name=>"tcs.tr2@arrivusystems.com",:account_name=>"tcs",:checking_account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
    cross_check_with_modules(:user_name=>"tcs.tr3@arrivusystems.com",:account_name=>"tcs",:checking_account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
  end



  ###### Student cross testing
  ##### IBM Students going to view Tcs domain modules by giving course id

  it "should show unauthorized message when Ibm students try to access Tcs course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"ibm.st1@arrivusystems.com",:account_name=>"ibm",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"ibm.st2@arrivusystems.com",:account_name=>"ibm",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"ibm.st3@arrivusystems.com",:account_name=>"ibm",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end

  it "should show unauthorized message when Ibm students try to access Tcs course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"ibm.st1@arrivusystems.com",:account_name=>"ibm",:checking_account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
    cross_check_with_modules(:user_name=>"ibm.st2@arrivusystems.com",:account_name=>"ibm",:checking_account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
    cross_check_with_modules(:user_name=>"ibm.st3@arrivusystems.com",:account_name=>"ibm",:checking_account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2,tcs_course2_module1,tcs_course2_module2,tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
  end



  ###### TCS Students going to view Ibm domain modules by giving course id

  it "should show unauthorized message when Tcs students try to access Ibm course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"tcs.st1@arrivusystems.com",:account_name=>"tcs",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"tcs.st2@arrivusystems.com",:account_name=>"tcs",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"tcs.st3@arrivusystems.com",:account_name=>"tcs",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end

  it "should show unauthorized message when Tcs students try to access Ibm course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"tcs.st1@arrivusystems.com",:account_name=>"tcs",:checking_account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
    cross_check_with_modules(:user_name=>"tcs.st2@arrivusystems.com",:account_name=>"tcs",:checking_account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
    cross_check_with_modules(:user_name=>"tcs.st3@arrivusystems.com",:account_name=>"tcs",:checking_account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2,ibm_course2_module1,ibm_course2_module2,ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module url")
  end







   #### teacher Cross checking in same domain


  it "should show unauthorized message when Ibm teachers try to access Tcs course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"ibm.tr1@arrivusystems.com",:account_name=>"ibm",:modules=>[ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"ibm.tr2@arrivusystems.com",:account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"ibm.tr3@arrivusystems.com",:account_name=>"ibm",:modules=>[ibm_course2_module1,ibm_course2_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end



  it "should show unauthorized message when Tcs teachers try to access Ibm course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"tcs.tr1@arrivusystems.com",:account_name=>"tcs",:modules=>[tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"tcs.tr2@arrivusystems.com",:account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"tcs.tr3@arrivusystems.com",:account_name=>"tcs",:modules=>[tcs_course2_module1,tcs_course2_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end

  #### students Cross checking in same domain

  it "should show unauthorized message when Ibm students try to access Tcs course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"ibm.st1@arrivusystems.com",:account_name=>"ibm",:modules=>[ibm_course3_module1,ibm_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"ibm.st2@arrivusystems.com",:account_name=>"ibm",:modules=>[ibm_course1_module1,ibm_course1_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"ibm.st3@arrivusystems.com",:account_name=>"ibm",:modules=>[ibm_course2_module1,ibm_course2_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end



  it "should show unauthorized message when Tcs students try to access Ibm course modules by using its course id and module id" do
    cross_check_with_modules(:user_name=>"tcs.st1@arrivusystems.com",:account_name=>"tcs",:modules=>[tcs_course3_module1,tcs_course3_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"tcs.st2@arrivusystems.com",:account_name=>"tcs",:modules=>[tcs_course1_module1,tcs_course1_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
    cross_check_with_modules(:user_name=>"tcs.st3@arrivusystems.com",:account_name=>"tcs",:modules=>[tcs_course2_module1,tcs_course2_module2],:checking_type=>"view modules one by one",:access_type=>"Change module id")
  end




end