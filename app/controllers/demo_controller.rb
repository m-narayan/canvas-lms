class DemoController < ApplicationController

  def demo_expired_email
    dm=DemoMessage.new
    dm.organization=@domain_root_account.name
    dm.message=params[:message]
    dm.save
    m=Message.new
    m.subject="#{@domain_root_account.name} demo has expired"
    #m.to = Account.site_admin.pseudonyms.first.unique_id
    m.to = DemoConfig.find(1).email
    body = params[:message]
    m.html_body=body
    Mailer.deliver_message(m)
    flash[:notice] = "We will be in touch with you very soon!!!"
    respond_to do |format|
      format.html {render :action => DemoConfig.find(1).redirect_url }
    end
  end

  def new
    return redirect_to(root_url) if @current_user
    @demo=Demo.new
  end

  def create
    @demo = Demo.new(params[:demo])
    organization=params[:demo][:organization].downcase.gsub(' ','')
    @demo.organization=organization
    recap = Canvas::Plugin.find('registration_form_recaptcha')
    captcha_valid=true
    if recap && !recap.settings[:public_key].blank? && !recap.settings[:private_key].blank?
      captcha_valid=verify_recaptcha(:model => @demo, :private_key => recap.settings[:private_key])
    end
    if captcha_valid
      @account = Account.find_by_name(organization)
      unless @account
        if @demo.save
          password=(0...10).map{ ('a'..'z').to_a[rand(26)] }.join
          @account = Account.new
          @account.name = organization
          @account.settings[:demo_account]= true
          @account.save
          save_demo_account_settings
          pseudonym = @account.pseudonyms.active.custom_find_by_unique_id(params[:demo][:email])
          user = pseudonym ? pseudonym.user : User.create!(:name => params[:demo][:email],
                                                           :sortable_name => params[:demo][:email])
          user.register! unless user.registered?
          unless pseudonym
            pseudonym = user.pseudonyms.create!(:unique_id => params[:demo][:email],
                                                :password => password, :password_confirmation => password,
                                                :account => @account )
            user.communication_channels.create!(:path => params[:demo][:email]) { |cc| cc.workflow_state = 'active' }
          end
          pseudonym.save
          @account.add_user(user, 'AccountAdmin')
          reset_session_for_login
          login={:unique_id =>params[:demo][:email],:password=>password,:remember_me=>"0"}
          @pseudonym_session = @account.pseudonym_sessions.new(login)
          @pseudonym_session.remote_ip = request.remote_ip
          @pseudonym_session.save
          send_email(params[:demo][:email],params[:demo][:name],password,organization)
          respond_to do |format|
            flash[:notice] = "Please check your email to use SmartLMS account"
            format.html{ redirect_to dashboard_url}
            #format.html{ redirect_to request.url.sub(current_subdomain, organization)}
            #format.html{ redirect_to request.server_name.sub(current_subdomain, organization)}
          end
        else
          respond_to do |format|
            format.html {render :action => "new"}
          end
        end
      else
        respond_to do |format|
          flash[:error] = "Organization Name Already Exists.Please choose a different name"
          format.html {render :action => "new"}
        end
      end
    else
        respond_to do |format|
          flash[:error] = "Invalid Captcha"
          format.html {render :action => "new"}
        end
    end
  end

  private
  def send_email(to,name,password,organization)
    m=Message.new
    m.subject="Your SmartLMS demo account information"
    m.to = to
    body = "Hi #{name}<br>"
    body=body+"Your username is #{to}<br>"
    body=body+"Your password is #{password}<br>"
    body=body+"<a href=\"#{request.protocol}://#{organization}.#{current_domain}\">Please visit your demo here</a><br>"
    m.html_body=body
    Mailer.deliver_message(m)
  end

  def save_demo_account_settings
    demo_settings=DemoAccountSettings.new
    demo_settings.account_id=@account.id
    demo_settings.remarks="Initial Trial"
    demo_settings.start_at=Time.now
    demo_settings.end_at=Time.now+30.days
    demo_settings.save
  end
end