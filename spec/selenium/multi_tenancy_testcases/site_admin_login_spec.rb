require File.expand_path(File.dirname(__FILE__) + '/common_mt')

  describe "Site_Admin user creation test" do

    it_should_behave_like "in-process server selenium tests"

    def fill_sms_settings_form(sms_url,username, password,sender_name)
      url_element= f('#account_settings_OpenLMS_sms_url')
      url_element.send_keys(sms_url)
      username_element = f('#account_settings_OpenLMS_sms_user')
      username_element.send_keys(username)
      password_element = f('#account_settings_OpenLMS_sms_password')
      password_element.send_keys(password)
      sender_element=f('#account_settings_OpenLMS_sms_sender_name')
      sender_element.send_keys(sender_name)
      password_element.submit
    end

    account=create_site_admin("openlms","openlms@arrivusystems.com","Admin123$")
    ibm_account=add_mt_account("ibm")
    add_mt_account_admin_users("ibm","ibm@arrivusystems.com","Admin123$")

    before do
      @login_error_box_css = ".error_text:last"
    end
    #
    #it "should create a admin user for openlms account and login with it" do
    #  driver.get "http://openlms.lvh.me:#{$server_port}"
    #  fill_in_login_form("openlms@arrivusystems.com","Admin123$")
    #  f('.user_name').text.should == "openlms@arrivusystems.com"
    #  driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{account.id}/settings"
    #  driver.get "http://openlms.lvh.me:#{$server_port}"
    #  driver.get "http://openlms.lvh.me:#{$server_port}/error_reports"
    #  expect_new_page_load { f('.logout > a').click }
    #
    #end
    #
    #it "should site admin user login in IBM account" do
    #  driver.get "http://ibm.lvh.me:#{$server_port}"
    #  fill_in_login_form("openlms@arrivusystems.com","Admin123$")
    #  f('.user_name').text.should == "openlms@arrivusystems.com"
    #  driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
    #  expect_new_page_load { f('.logout > a').click }
    #
    #end

    #it "should login as a site administrator and visit plugin settings" do
    #  driver.get "http://openlms.lvh.me:#{$server_port}"
    #  fill_in_login_form("openlms@arrivusystems.com","Admin123$")
    #  f('.user_name').text.should == "openlms@arrivusystems.com"
    #  driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
    #  f("#tab-plugin-link").click
    #  driver.find_element(:id, 'account_settings_OpenLMS_kaltura_disable').click
    #  driver.find_element(:id, 'account_settings_OpenLMS_sub_account_disable').click
    #  driver.find_element(:id, 'account_settings_OpenLMS_grade_disable').click
    #
    #  #f("#account_settings_OpenLMS_kaltura_disable").click
    #  #f("account_settings_OpenLMS_bbb_disable").click
    #  #f("account_settings_OpenLMS_kandan_chat_disable").click
    #  #f("account_settings_OpenLMS_google_docs_disable").click
    #  #f("account_settings_OpenLMS_Crocodoc_disable").click
    #  #f("account_settings_OpenLMS_grade_disable").click
    #  #f("account_settings_OpenLMS_outcomes_disable").click
    #  #f("account_settings_OpenLMS_sub_account_disable").click
    #  #f("#btn_plugin_submit").click
    #  submit_form("#account_plugin_settings")
    #  #sleep(10)
    #  #wait_for_ajax_requests
    #
    #  driver.get "http://openlms.lvh.me:#{$server_port}"
    #  driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
    #  f("#tab-plugin-link").click
    #  expect_new_page_load { f('.logout > a').click }
    #
    #
    #  driver.get "http://ibm.lvh.me:#{$server_port}"
    #  fill_in_login_form("ibm@arrivusystems.com","Admin123$")
    #  f('.user_name').text.should == "ibm@arrivusystems.com"
    #  driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
    #
    #end

    #it "should login as a site administrator and visit plugin settings" do
    #  driver.get "http://openlms.lvh.me:#{$server_port}"
    #  fill_in_login_form("openlms@arrivusystems.com","Admin123$")
    #  f('.user_name').text.should == "openlms@arrivusystems.com"
    #  driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{account.id}/settings"
    #  f("#tab-sms-settings-link").should be_displayed
    #  f("#tab-plugin-link").should be_displayed
    #  f("#tab-sms-settings-link").click
    #  sleep(5)
    #  f("#tab-plugin-link").click
    #  sleep(5)
    #  expect_new_page_load { f('.logout > a').click }
    #end
    #
    #it "should site administrator set the details for sms settings for IBM account" do
    #  driver.get "http://openlms.lvh.me:#{$server_port}"
    #  fill_in_login_form("openlms@arrivusystems.com","Admin123$")
    #  driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{account.id}/settings"
    #  f("#tab-sms-settings-link").click
    #  fill_sms_settings_form("www.test.com","test username","test password","test sender")
    #  f("#tab-sms-settings-link").click
    #  sleep(5)

          #for ref element.getAttributte("value")=test username
          #selenium.getValue(“//input[@id='qu']“)
    #end

    it "should login as a site administrator to disable grades for ibm account" do
      driver.get "http://openlms.lvh.me:#{$server_port}"
      fill_in_login_form("openlms@arrivusystems.com","Admin123$")
      driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
      f("#tab-plugin-link").should be_displayed
      f("#tab-plugin-link").click
      driver.find_element(:id, 'account_settings_OpenLMS_grade_disable').click
      submit_form("#account_plugin_settings")
      driver.find_element(:css,'body').send_keys [:control,'t']
      driver.get "http://ibm.lvh.me:#{$server_port}"
      fill_in_login_form("ibm@arrivusystems.com","Admin123$")
      f('.user_name').text.should == "ibm@arrivusystems.com"
      driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
      f('.grading_standards').text.should=="Grading Schemes"
      f('.grading_standards').click
      driver.find_element(:id, 'content').should be_displayed
      f("#content").text.should include_text "Feature is not Enabled"
      driver.find_element(:id, 'feature_wish_submit').should be_displayed
      puts "#{$server_port}"
      f('.user_name').click
      sleep(5)
    end

  end