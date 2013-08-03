
require File.expand_path(File.dirname(__FILE__) + '/common_mt')

describe "Acount creation and Admin user creation test" do

  it_should_behave_like "in-process server selenium tests"

  add_mt_account("ibm")
  add_mt_account_admin_users("ibm","ibm@arrivusystems.com","Admin123$")
  add_sub_account_mt("ibm_sub_account1","ibm")
  #add_sub_account_mt("ibm_sub_account2","ibm")
  add_mt_account_admin_users("ibm_sub_account1","ibm.s1@arrivusystems.com","Admin123$")
  #add_mt_account_admin_users("ibm_sub_account2","ibm.s2@arrivusystems.com","Admin123$")

  #add_mt_account("tcs")
  #add_sub_account_mt("tcs_sub_account1","tcs")
  #add_sub_account_mt("tcs_sub_account2","tcs")
  #add_mt_account_admin_users("tcs_sub_account1","tcs.s1@arrivusystems.com","Admin123$")
  #add_mt_account_admin_users("tcs_sub_account2","tcs.s2@arrivusystems.com","Admin123$")
  #
  #add_mt_account("cisco")
  #add_sub_account_mt("cisco_sub_account1","cisco")
  #add_sub_account_mt("cisco_sub_account2","cisco")
  #add_mt_account_admin_users("cisco_sub_account1","cisco.s1@arrivusystems.com","Admin123$")
  #add_mt_account_admin_users("cisco_sub_account2","cisco.s2@arrivusystems.com","Admin123$")
  #
  #add_mt_account("beacon")
  #add_sub_account_mt("beacon_sub_account1","beacon")
  #add_sub_account_mt("beacon_sub_account2","beacon")
  #add_mt_account_admin_users("beacon_sub_account1","beacon.s1@arrivusystems.com","Admin123$")
  #add_mt_account_admin_users("beacon_sub_account2","beacon.s2@arrivusystems.com","Admin123$")
  #
  #add_mt_account("infosys")
  #add_sub_account_mt("infosys_sub_account1","infosys")
  #add_sub_account_mt("infosys_sub_account2","infosys")
  #add_mt_account_admin_users("infosys_sub_account1","infosys.s1@arrivusystems.com","Admin123$")
  #add_mt_account_admin_users("infosys_sub_account2","infosys.s2@arrivusystems.com","Admin123$")


  #before do
  #  @login_error_box_css = ".error_text:last"
  #end

  it "should login as a admin user in ibm_sub_account1" do

    driver.get "http://ibm.lvh.me:#{$server_port}"
    fill_in_login_form("ibm@arrivusystems.com","Admin123$")
    #f('.user_name').text.should == "ibm_sub_account1"
    #expect_new_page_load { f('.logout > a').click }
  end

  #it "should login as a admin user in ibm_sub_account2" do
  #  driver.get "http://localhost:#{$server_port}"
  #  fill_in_login_form("ibm.s2@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "ibm.s2@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end

  #it "should login as a admin user in tcs_sub_account1" do
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s1@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "tcs.s1@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end
  #
  #it "should login as a admin user in tcs_sub_account2" do
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s2@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "tcs.s2@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end
  #
  #it "should login as a admin user in cisco_sub_account1" do
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco.s1@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "cisco.s1@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end
  #
  #it "should login as a admin user in cisco_sub_account2" do
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco.s2@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "cisco.s2@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end
  #
  #it "should login as a admin user in beacon_sub_account1" do
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s1@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "beacon.s1@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end
  #
  #it "should login as a admin user in beacon_sub_account2" do
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s2@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "beacon.s2@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end
  #
  #it "should login as a admin user in infosys_sub_account1" do
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s1@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "infosys.s1@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end
  #
  #it "should login as a admin user in infosys_sub_account2" do
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s2@arrivusystems.com","Admin123$")
  #  f('.user_name').text.should == "infosys.s2@arrivusystems.com"
  #  expect_new_page_load { f('.logout > a').click }
  #end
  #
  #it "should not login when other domain users login in IBM domain" do
  #
  #  driver.get "http://ibm.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://ibm.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://ibm.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://ibm.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://ibm.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://ibm.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://ibm.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://ibm.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #end
  #
  #it "should not login when other domain users login in TCS domain" do
  #
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("ibm.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("ibm.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco@.s1arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco@.s2arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://tcs.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #
  #end
  #
  #it "should not login when other domain users login in CISCO domain" do
  #
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("ibm.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("ibm.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://cisco.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #end
  #
  #it "should not login when other domain users login in INFOSYS domain" do
  #
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("ibm.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("ibm.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("beacon.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://infosys.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #end
  #
  #it "should not login when other domain users login in BEACON domain" do
  #
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("ibm.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("ibm.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("tcs.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("cisco.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s1@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #  driver.get "http://beacon.lvh.me:#{$server_port}"
  #  fill_in_login_form("infosys.s2@arrivusystems.com","Admin123$")
  #  assert_flash_error_message /Incorrect username/
  #
  #end

end