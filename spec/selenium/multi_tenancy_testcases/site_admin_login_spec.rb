require File.expand_path(File.dirname(__FILE__) + '/common_mt')

  describe "Site_Admin user creation test" do

    it_should_behave_like "in-process server selenium tests"
    #@account=add_mt_account("openlms")
    #user=  add_mt_account_admin_users("openlms","openlms@arrivusystems.com","Admin123$")
    account_id=create_site_admin("openlms","openlms@arrivusystems.com","Admin123$")
    ibm_account=add_mt_account("ibm")


    before do
      @login_error_box_css = ".error_text:last"
    end

    it "should create a admin user for openlms account and login with it" do
      driver.get "http://openlms.lvh.me:#{$server_port}"
      fill_in_login_form("openlms@arrivusystems.com","Admin123$")
      f('.user_name').text.should == "openlms@arrivusystems.com"
      driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{account_id}/settings"
      expect_new_page_load { f('.logout > a').click }

    end

    it "should site admin user login in IBM account" do
      driver.get "http://ibm.lvh.me:#{$server_port}"
      fill_in_login_form("openlms@arrivusystems.com","Admin123$")
      f('.user_name').text.should == "openlms@arrivusystems.com"
      expect_new_page_load { f('.logout > a').click }

    end

    it "should login as a site administrator and visit plugin settings" do
      driver.get "http://openlms.lvh.me:#{$server_port}"
      fill_in_login_form("openlms@arrivusystems.com","Admin123$")
      f('.user_name').text.should == "openlms@arrivusystems.com"
      driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
      f("#tab-plugin-link").click
      f("#account_settings_OpenLMS_kaltura_disable").click

      submit_form("#account_plugin_settings")
      driver.get "http://openlms.lvh.me:#{$server_port}"
      driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
      f("#tab-plugin-link").click
      wait_for_ajaximations
      puts "#{$server_port}"
    end
  end