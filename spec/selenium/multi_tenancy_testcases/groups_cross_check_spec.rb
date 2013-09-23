require File.expand_path(File.dirname(__FILE__) + '/common_mt')
require File.expand_path(File.dirname(__FILE__) + '/data_setup_for_groups')



describe "groups_cross_checking" do

  it_should_behave_like "in-process server selenium tests"

  def view_group(params={})
    params[:user_name].each do |user_name|
      driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}"
      fill_in_login_form(user_name,"Admin123$")
      wait_for_ajaximations
      f('.user_name').text.should == user_name
      group=params[:group]
      course=Course.find(group.context_id)
      driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/courses/#{course.id}/groups"
      wait_for_ajaximations
      f("#section-tabs-header").text.should include_text course.course_code
      if params[:user_role]== "student"
        f(".group_name").text.should include_text group.name
        fj("a:contains('Start a New Group')").should be_displayed
        fj(".toggle_members_link").click
        wait_for_ajaximations
        params[:group_members].each do |group_member_name|
          f(".member_list").text.should include_text group_member_name
        end
      elsif params[:user_role]=="teacher"
        f(".left_side").text.should include_text group.name
        params[:group_members].each do |group_member_name|
          wait_for_ajaximations
          f("#tabs_loading_wrapper").text.should include_text group_member_name
        end
        fj("a:contains(' Make a New Set of Groups')").should be_displayed
      end
      driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/groups/#{group.id}"
      f("#section-tabs-header").text.should include_text group.name
      f("#section-tabs-header-subtitle").text.should include_text course.name
      fj("a:contains('New Announcement')").should be_displayed
      f(".recent-activity-header").text.should include_text "Recent Activity in #{group.name}"
      expect_new_page_load { f('.logout > a').click }
    end
  end


  #### Ibm domain group members viewing their groups

  #it "should allow to view the group when Ibm course1's group1's students try to view the group" do
  #   view_group(:account_name=>"ibm",:user_name=>["ibm.st1@arrivusystems.com","ibm.st2@arrivusystems.com"],:group=>ibm_course1_group1,
  #              :user_role=>"student",:group_members=>["ibm.st1@arrivusystems.com","ibm.st2@arrivusystems.com","ibm.tr1@arrivusystems.com"])
  #end

  #it "should allow to view the group when Ibm course1's group2's students try to view the group" do
  #  view_group(:account_name=>"ibm",:user_name=>["ibm.st3@arrivusystems.com","ibm.st4@arrivusystems.com"],:group=>ibm_course1_group2,
  #             :user_role=>"student",:group_members=>["ibm.st3@arrivusystems.com","ibm.st4@arrivusystems.com","ibm.tr2@arrivusystems.com"])
  #end


  #it "should allow to view the group when Ibm course2's group1's students try to view the group" do
  #   view_group(:account_name=>"ibm",:user_name=>["ibm.st5@arrivusystems.com","ibm.st6@arrivusystems.com"],:group=>ibm_course2_group1,
  #              :user_role=>"student",:group_members=>["ibm.st5@arrivusystems.com","ibm.st6@arrivusystems.com","ibm.tr3@arrivusystems.com"])
  #end
  #
  #it "should allow to view the group when Ibm course2's group2's students try to view the group" do
  #  view_group(:account_name=>"ibm",:user_name=>["ibm.st7@arrivusystems.com","ibm.st8@arrivusystems.com"],:group=>ibm_course2_group2,
  #             :user_role=>"student",:group_members=>["ibm.st7@arrivusystems.com","ibm.st8@arrivusystems.com","ibm.tr4@arrivusystems.com"])
  #end
  
  
  ###### Tcs domain group members viewing their group

    #it "should allow to view the group when tcs course1's group1's students try to view the group" do
    #
    #   view_group(:account_name=>"tcs",:user_name=>["tcs.st1@arrivusystems.com","tcs.st2@arrivusystems.com"],:group=>tcs_course1_group1,
    #              :user_role=>"student",:group_members=>["tcs.st1@arrivusystems.com","tcs.st2@arrivusystems.com","tcs.tr1@arrivusystems.com"])
    #end
    #
    #it "should allow to view the group when tcs course1's group2's students try to view the group" do
    #  view_group(:account_name=>"tcs",:user_name=>["tcs.st3@arrivusystems.com","tcs.st4@arrivusystems.com"],:group=>tcs_course1_group2,
    #             :user_role=>"student",:group_members=>["tcs.st3@arrivusystems.com","tcs.st4@arrivusystems.com","tcs.tr2@arrivusystems.com"])
    #end
    #
    #
    #it "should allow to view the group when tcs course2's group1's students try to view the group" do
    #  view_group(:account_name=>"tcs",:user_name=>["tcs.st5@arrivusystems.com","tcs.st6@arrivusystems.com"],:group=>tcs_course2_group1,
    #             :user_role=>"student",:group_members=>["tcs.st5@arrivusystems.com","tcs.st6@arrivusystems.com","tcs.tr3@arrivusystems.com"])
    #end
    #
    #it "should allow to view the group when tcs course2's group2's students try to view the group" do
    #  view_group(:account_name=>"tcs",:user_name=>["tcs.st7@arrivusystems.com","tcs.st8@arrivusystems.com"],:group=>tcs_course2_group2,
    #             :user_role=>"student",:group_members=>["tcs.st7@arrivusystems.com","tcs.st8@arrivusystems.com","tcs.tr4@arrivusystems.com"])
    #end

    #
    it "should allow to view the group when Ibm teacher1 try to view the group" do
      view_group(:account_name=>"ibm",:user_name=>["ibm.tr1@arrivusystems.com"],:group=>ibm_course1_group1,:user_role=>"teacher",
                 :group_members=>["ibm.st1@arrivusystems.com","ibm.st2@arrivusystems.com","ibm.tr1@arrivusystems.com"])
    end

    it "should allow to view the group when Ibm teacher2 try to view the group" do
      view_group(:account_name=>"ibm",:user_name=>["ibm.tr2@arrivusystems.com"],:group=>ibm_course1_group2,:user_role=>"teacher",
                 :group_members=>["ibm.st3@arrivusystems.com","ibm.st4@arrivusystems.com","ibm.tr2@arrivusystems.com"])
    end
end

