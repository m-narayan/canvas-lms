class DemoController < ApplicationController

  def new
    return redirect_to(root_url) if @current_user
    @demo=Demo.new
  end

  def create
    @demo = Demo.new(params[:demo])
    respond_to do |format|
    recap = Canvas::Plugin.find('registration_form_recaptcha')
    captcha_valid=true
    if recap && !recap.settings[:public_key].blank? && !recap.settings[:private_key].blank?
      captcha_valid=verify_recaptcha(:model => @demo, :private_key => recap.settings[:private_key])
    end
    if captcha_valid
        @account = Account.find_by_name(params[:demo][:organization])
        unless @account
          if @demo.save
            password=(0...10).map{ ('a'..'z').to_a[rand(26)] }.join
            @account = Account.new
            @account.name = params[:demo][:organization]
            @account.save
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
            format.html{ redirect_to dashboard_url}

            cc=CommunicationChannel.new
            m=cc.messages.new
            m.to = "params[:demo][:email]"
            m.body = "hello"
            Mailer.deliver_message(m) rescue nil
          else
            format.html {render :action => "new"}
          end
        else
          flash[:error] = "Organization Name Already Exists.Please choose a different name"
          format.html {render :action => "new"}
        end
    else
      flash[:error] = "Invalid Captcha"
      format.html {render :action => "new"}
    end
  end
end
end
