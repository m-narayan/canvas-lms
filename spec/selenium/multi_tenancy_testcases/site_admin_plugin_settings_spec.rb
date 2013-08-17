require File.expand_path(File.dirname(__FILE__) + '/common_mt')

  describe "Site_Admin user creation test" do

    it_should_behave_like "in-process server selenium tests"


    account=create_site_admin("openlms","openlms@arrivusystems.com","Admin123$")
    ibm_account=add_mt_account("ibm")
    add_mt_account_admin_users("ibm","ibm@arrivusystems.com","Admin123$")
    course=create_course("IBM course M1-Sample Course1","IBMM1","ibm")


    def admin_login(params={})
      driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}"
      fill_in_login_form(params[:user_name],params[:password])
      f('.user_name').text.should == params[:user_name]
      driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/accounts/#{params[:account_id]}/settings"

    end

    def site_admin_logout
      expect_new_page_load { f('.logout > a').click }
    end

    before do
      @login_error_box_css = ".error_text:last"
    end

    it "should login as a site administrator to disable grades for ibm account" do

      admin_login(:account_name=>"openlms",:user_name=>"openlms@arrivusystems.com",:password=>"Admin123$",:account_id=>ibm_account.id)
      f("#tab-plugin-link").should be_displayed
      f("#tab-plugin-link").click
      driver.find_element(:id, 'account_settings_OpenLMS_grade_disable').click
      submit_form("#account_plugin_settings")
      #to check in quizzes
      driver.find_element(:css,'body').send_keys [:control,'t']
      #driver.get "http://ibm.lvh.me:#{$server_port}"
      #fill_in_login_form("ibm@arrivusystems.com","Admin123$")
      admin_login(:account_name=>"ibm",:user_name=>"ibm@arrivusystems.com",:password=>"Admin123$",:account_id=>ibm_account.id)


      #driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{ibm_account.id}"
      f('.grading_standards').text.should=="Grading Schemes"
      fj('.grading_standards').click
      driver.find_element(:id, 'content').should be_displayed
      f("#content").text.should include_text "Feature is not Enabled"
      driver.find_element(:id, 'feature_wish_submit').should be_displayed
      driver.find_element(:id, 'feature_wish_submit').click
      assert_flash_notice_message /Your request was sent to admin,The administrator will contact you soon/
      sleep(2)

      #check, are the grading schemes present in quizzes or not
      driver.get "http://ibm.lvh.me:#{$server_port}/courses/#{course.id}/quizzes"
      expect_new_page_load {fj("a:contains(' Create a New Quiz')").click }
      driver.find_element(:id, 'quiz_edit_wrapper').should be_displayed
      driver.find_element(:id, 'quiz_tabs').should be_displayed
      driver.find_element(:id, 'ui-id-1').should be_displayed
      driver.find_element(:id, 'quiz_assignment_id').should be_displayed
      f("#quiz_assignment_id").click
      sleep(2)
      f("#quiz_assignment_id").should have_value "practice_quiz"
      f("#quiz_assignment_id").should_not have_value "assignment"
      f("#quiz_assignment_id").should_not have_value "graded_survey"
      sleep(2)

      #check, are the grading schemes present in course settings
      driver.get "http://ibm.lvh.me:#{$server_port}/courses/#{course.id}/gradebook2"
      #driver.get "http://ibm.lvh.me:#{$server_port}/courses/#{course.id}/gradebook2"
      #if it is old gradebook, this testwill fail
      driver.find_element(:id, 'content').should be_displayed
      f("#content").text.should include_text "Feature is not Enabled"
      driver.find_element(:id, 'feature_wish_submit').should be_displayed
      driver.find_element(:id, 'feature_wish_submit').click

      #to check grade in creating discussions
      driver.get "http://ibm.lvh.me:#{$server_port}/courses/#{course.id}/discussion_topics"
      driver.find_element(:id, 'new-discussion-btn').click
      #can use follows instead above two lines
      #driver.get "http://ibm.lvh.me:#{$server_port}/courses/#{course.id}/discussion_topics/new"
      driver.find_element(:id, 'discussion-title').should be_displayed
      #f("#use_for_grading").should_not be_displayed
      #f('.custom_help_link:nth-child(2)').should_not be_displayed
      fj('#use_for_grading:visible').should be_nil

    end

    it "should login as a site administrator to disable outcomes for ibm account" do
      #switch to previous tab
      #driver.find_element(:css,'body').send_keys [:alt,'1']
      admin_login(:account_name=>"openlms",:user_name=>"openlms@arrivusystems.com",:password=>"Admin123$",:account_id=>ibm_account.id)
      #driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{ibm_account.id}"
      f("#tab-plugin-link").click
      driver.find_element(:id, 'account_settings_OpenLMS_grade_disable').click
      driver.find_element(:id, 'account_settings_OpenLMS_outcomes_disable').click
      sleep 2
      submit_form("#account_plugin_settings")
      #driver.find_element(:css,'body').send_keys [:alt,'2']
      driver.find_element(:css,'body').send_keys [:control,'t']
      admin_login(:account_name=>"ibm",:user_name=>"ibm@arrivusystems.com",:password=>"Admin123$",:account_id=>ibm_account.id)
      driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{ibm_account.id}"
      f('.outcomes').text.should=="Outcomes"
      fj('.outcomes').click

      driver.find_element(:id, 'content').should be_displayed
      f("#content").text.should include_text "Feature is not Enabled"
      driver.find_element(:id, 'feature_wish_submit').should be_displayed
      driver.find_element(:id, 'feature_wish_submit').click
      assert_flash_notice_message /Your request was sent to admin,The administrator will contact you soon/
      sleep(2)

      #check in rubric
      driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/rubrics"
      expect_new_page_load {fj("a:contains(' Add Rubric')").click }


      f(".icon-search find_outcome_link outcome").should_not be_displayed
      sleep 5
    end

    it "should disable course import" do

        #driver.find_element(:css,'body').send_keys [:alt,'1']
        admin_login(:account_name=>"openlms",:user_name=>"openlms@arrivusystems.com",:password=>"Admin123$",:account_id=>ibm_account.id)
        #driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{ibm_account.id}"
        f("#tab-plugin-link").click
        driver.find_element(:id, 'account_settings_OpenLMS_course_import_disable').click

        sleep 2
        submit_form("#account_plugin_settings")
        #driver.find_element(:css,'body').send_keys [:alt,'2']
        driver.find_element(:css,'body').send_keys [:control,'t']

        admin_login(:account_name=>"ibm",:user_name=>"ibm@arrivusystems.com",:password=>"Admin123$",:account_id=>ibm_account.id)
        driver.get "http://ibm.lvh.me:#{$server_port}/courses/#{ibm_coruse.id}/settings"



        #check in rubric
        driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{course.id}/rubrics"
        expect_new_page_load {fj("a:contains(' Add Rubric')").click }


        f(".icon-search find_outcome_link outcome").should_not be_displayed
        sleep 5
      end

    it "should disable course import" do
      #driver.find_element(:css,'body').send_keys [:alt,'1']
      admin_login(:account_name=>"openlms",:user_name=>"openlms@arrivusystems.com",:password=>"Admin123$",:account_id=>ibm_account.id)
      #driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{ibm_account.id}"
      f("#tab-plugin-link").click
      driver.find_element(:id, 'account_settings_OpenLMS_course_import_disable').click

      sleep 2
      submit_form("#account_plugin_settings")
      #driver.find_element(:css,'body').send_keys [:alt,'2']
      driver.find_element(:css,'body').send_keys [:control,'t']

      admin_login(:account_name=>"ibm",:user_name=>"ibm@arrivusystems.com",:password=>"Admin123$",:account_id=>ibm_account.id)
      driver.get "http://ibm.lvh.me:#{$server_port}/courses/#{course.id}/settings"

      #check in rubric
      driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/rubrics"
      expect_new_page_load {fj("a:contains(' Add Rubric')").click }

      f(".icon-search find_outcome_link outcome").should_not be_displayed
      sleep 5
    end
  end