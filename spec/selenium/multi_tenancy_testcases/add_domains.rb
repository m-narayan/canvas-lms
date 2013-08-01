 require File.expand_path(File.dirname(__FILE__) + '/common_mt')

 describe "domain creation test" do
	#driver = Selenium::WebDriver.for :firefox
	it_should_behave_like "in-process server selenium tests"

  def add_accound_and_admin
    add_mt_account("ibm")
    add_mt_account_admin_users("ibm@arrivusystems.com","Admin123$","ibm")
  end
  

  before do
    @login_error_box_css = ".error_text:last"
  end
	
  # it "should show error message if wrong credentials are used" do
  #   login_as("fake@user.com", "fakepass")
  #   assert_flash_error_message /Incorrect username/
  # end

  it "should create a domain for IBM" do
    
    driver.get "http://ibm.lvh.me:#{$server_port}"
    expected_error = "Invalid password"
    login_as("test@gmail.com", "fakepass", false)
    assert_flash_error_message /Incorrect username/
    # login_as_mt("test@gmail.com", "test123$")
    # should_show_message(expected_error, @login_error_box_css)
    #driver.quit
  end

  it "should create  a admin user for ibm account" do
      #add_mt_account("ibm")
      
      driver.get "http://ibm.lvh.me:#{$server_port}"
      login_as("ibm@arrivusystems.com","Admin123$", true)
      puts "user login name : #{@user.primary_pseudonym.unique_id}"
      #user_with_pseudonym({:active_user => true})
      puts "user login name : #{@user.primary_pseudonym.unique_id}"
        f('.user_name').text.should == @user.primary_pseudonym.unique_id
        driver.get "http://ibm.lvh.me:#{$server_port}/accounts"

      end

 # 	it "shoudld create a domain for TCS" do
 #    add_mt_account("tcs")
 #    driver.get "http://tcs.lvh.me:#{$server_port}"
 #    expected_error = "Invalid password"
 #    login_as_mt("test@gmail.com", "fakepass", "tcs")
 #    assert_flash_error_message /Incorrect username/
	# end

 # 	it "shoudld create a domain for BEACON" do
 #    	add_mt_account("beacon")
	# end

 # 	it "shoudld create a domain for INFOSYS" do
 #    	add_mt_account("infosys")
	# end

 # 	it "shoudld create a domain for CISCO" do
 #    	add_mt_account("cisco")
	# end



 end