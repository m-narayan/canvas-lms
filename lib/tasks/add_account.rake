namespace :db do

  task add_account: :environment do


    if (ENV['CANVAS_LMS_ACCOUNT_NAME'] || "").empty?
      require 'highline/import'

      if !Rails.env.test?
        name = ask("Enter  Account name > ") { |q| q.echo = true }
        #name = "beacon"
        @account = Account.find_by_name(name)
        unless @account
          @account = Account.new
          @account.name = name
          puts "Creating Account #{name}... "
          @account.save!
          #now add the siteAdmin account admin to this account admin
          site_admin_ac_admin_user = Account.site_admin.account_users.first
          @account.add_user(site_admin_ac_admin_user.user, 'SiteAdmin')
          @account.save!
          puts "added the site-admin to the list of account admins"
        else
          puts "Account Already Exists"
        end
      end
    end

    def create_admin_user(email, password)
      begin
        pseudonym = @account.pseudonyms.active.custom_find_by_unique_id(email)
        puts "#{pseudonym}"
        user = pseudonym ? pseudonym.user : User.create!(:name => email,
                                                         :sortable_name => email)
        puts "#{user.name} user created"
        user.register! unless user.registered?

        unless pseudonym
          # don't pass the password in the create call, because that way is extra
          # picky. the admin should know what they're doing, and we'd rather not
          # fail here.
          puts "#{email}"
          pseudonym = user.pseudonyms.create!(:unique_id => email,
                                              :password => "validpassword", :password_confirmation => "validpassword",
                                              :account => @account )
          user.communication_channels.create!(:path => email) { |cc| cc.workflow_state = 'active' }
        end
        # set the password later.
        pseudonym.password = pseudonym.password_confirmation = password
        unless pseudonym.save
          raise pseudonym.errors.first.join " " if pseudonym.errors.size > 0
          raise "unknown error saving password"
        end
        @account.add_user(user, 'AccountAdmin')
        user
      rescue Exception => e
        STDERR.puts "Problem creating administrative account, please try again:{#e.mesaage}\n#{e.backtrace} "
        nil
      end
    end

    user = nil
    if !(ENV['CANVAS_LMS_ADMIN_EMAIL'] || "").empty? && !(ENV['CANVAS_LMS_ADMIN_PASSWORD'] || "").empty?
      user = create_admin(ENV['CANVAS_LMS_ADMIN_EMAIL'], ENV['CANVAS_LMS_ADMIN_PASSWORD'])
    end

    unless user
      require 'highline/import'

      !Rails.env.test?

      while true do
        email = ask("What email address will the site administrator account use? > ") { |q| q.echo = true }
        email_confirm = ask("Please confirm > ") { |q| q.echo = true }
        #email = "beacon@beacon.com"
        #email_confirm = "beacon@beacon.com"
        break if email == email_confirm
      end

      while true do
        password = ask("What password will the site administrator use? > ") { |q| q.echo = "*" }
        password_confirm = ask("Please confirm > ") { |q| q.echo = "*" }
        #password = "123456789"
        #password_confirm = "123456789"
        break if password == password_confirm
      end

      create_admin_user(email, password)
      puts "Successfully created admin user with email: #{email}, password: #{password} for account: #{@account.name}"
    end
 end

end
