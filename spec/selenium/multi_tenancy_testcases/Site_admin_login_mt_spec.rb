require File.expand_path(File.dirname(__FILE__) + '/common_mt')

describe "Site_Admin user creation and Login test" do

  it_should_behave_like "in-process server selenium tests"


  openlms_account=create_site_admin("openlms","openlms@arrivusystems.com","Admin123$")

  ibm_account=add_mt_account("ibm")
  add_mt_account_admin_users("ibm","ibm@arrivusystems.com","Admin123$")

  tcs_account=add_mt_account("tcs")
  add_mt_account_admin_users("tcs","tcs@arrivusystems.com","Admin123$")

  cisco_account=add_mt_account("cisco")
  add_mt_account_admin_users("cisco","cisco@arrivusystems.com","Admin123$")

  beacon_account=add_mt_account("beacon")
  add_mt_account_admin_users("beacon","beacon@arrivusystems.com","Admin123$")

  infosys_account=add_mt_account("infosys")
  add_mt_account_admin_users("infosys","infosys@arrivusystems.com","Admin123$")


  before do
    @login_error_box_css = ".error_text:last"
  end

  def site_admin_login(params={})
    driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}"
    fill_in_login_form(params[:user_name],params[:password])
    f('.user_name').text.should == params[:user_name]
    driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/accounts/#{params[:account_id]}/settings"
    f("#tab-sms-settings-link").should be_displayed
    f("#tab-plugin-link").should be_displayed
    f("#tab-sms-settings-link").click
    sleep 2
    f("#tab-plugin-link").click
    sleep 2
    driver.get "http://#{params[:account_name]}.lvh.me:#{$server_port}/accounts/#{params[:check_account_id]}/settings"
    f("#section-tabs-header").text.should==params[:account_to_check]
    f("#tab-sms-settings-link").should be_displayed
    f("#tab-plugin-link").should be_displayed
    f("#tab-sms-settings-link").click
    sleep 2
    f("#tab-plugin-link").click
    sleep 2
    expect_new_page_load { f('.logout > a').click }
  end

  it "should login as a site administrator and visit plugin settings in OPENLMS account" do
    #driver.get "http://openlms.lvh.me:#{$server_port}"
    #fill_in_login_form("openlms@arrivusystems.com","Admin123$")
    #f('.user_name').text.should == "openlms@arrivusystems.com"
    #driver.get "http://openlms.lvh.me:#{$server_port}/accounts/#{account.id}/settings"
    #f("#tab-sms-settings-link").should be_displayed
    #f("#tab-plugin-link").should be_displayed
    #f("#tab-sms-settings-link").click
    #sleep 2
    #f("#tab-plugin-link").click
    #sleep 2
    #expect_new_page_load { f('.logout > a').click }
    site_admin_login(:account_name=>"openlms",:account_id=>openlms_account.id,:account_to_check =>"ibm",:check_account_id=>ibm_account.id, :user_name=>"openlms@arrivusystems.com", :password=>"Admin123$")
  end



  it "should site admin user login in IBM account" do
    driver.get "http://ibm.lvh.me:#{$server_port}"
    fill_in_login_form("openlms@arrivusystems.com","Admin123$")
    f('.user_name').text.should == "openlms@arrivusystems.com"
    driver.get "http://ibm.lvh.me:#{$server_port}/accounts/#{ibm_account.id}/settings"
    expect_new_page_load { f('.logout > a').click }

  end

end