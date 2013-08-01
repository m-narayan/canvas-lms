require File.expand_path(File.dirname(__FILE__) + '/common_mt')

describe "domain creation test" do
  #driver = Selenium::WebDriver.for :firefox
  it_should_behave_like "in-process server selenium tests"


  def account_creation_with_admin_user
    add_mt_account('ibm',$server_port)
    add_mt_admin_user('ibm@arrivusystems.com','Admin123$','ibm')
    add_mt_account('tcs',$server_port)
    add_mt_admin_user('tcs@arrivusystems.com','Admin123$','tcs')
    add_mt_account('cisco',$server_port)
    add_mt_admin_user('cisco@arrivusystems.com','Admin123$','cisco')
    add_mt_account('infosys',$server_port)
    add_mt_admin_user('infosys@arrivusystems.com','Admin123$','infosys')
    add_mt_account('beacon',$server_port)
    add_mt_admin_user('beacon@arrivusystems.com','Admin123$','beacon')
  end

  def should_show_message(message_text, selector)
    fj(selector).should include_text(message_text)
    # the text isn't visible on the page so the webdriver .text method doesn't return it
    driver.execute_script("return $('#aria_alerts div:last').text()").should == message_text
  end

  before do
    @login_error_box_css = ".error_text:last"
  end


  it "should login successfully with correct username and password" do
    add_mt_account('ibm',$server_port)
    add_mt_admin_user('ibm@arrivusystems.com','Admin123$','ibm')
    user_with_pseudonym({:active_user => true})
    login_as("ibm@arrivusystems.com","Admin123$", true)
    f('.user_name').text.should == @user.primary_pseudonym.unique_id
  end

  it "should show error message if wrong credentials are used" do
    login_as("fake@user.com", "fakepass", false)
    assert_flash_error_message /Incorrect username/
  end





end