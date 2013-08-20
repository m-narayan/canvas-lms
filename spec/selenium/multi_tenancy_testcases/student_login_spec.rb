require File.expand_path(File.dirname(__FILE__) + '/common_mt')

describe "user creation and login test" do

  it_should_behave_like "in-process server selenium tests"

  ibm_account=add_mt_account("ibm")
  ibm_course=course(:course_name=>"IBM course M1-Sample Course1", :account=>ibm_account, :active_course=>true)
  @current_user=add_user("ibm","ibm.st1@arrivusystems.com","Admin123$")
  ibm_course.enroll_user(@current_user, 'StudentEnrollment', :enrollment_state => 'active')

  it "should login as a student " do
    driver.get "http://ibm.lvh.me:#{$server_port}"
    fill_in_login_form("ibm.st1@arrivusystems.com","Admin123$")
    f('.user_name').text.should == "ibm.st1@arrivusystems.com"
    sleep 5
    expect_new_page_load { f('.logout > a').click }
  end


end
