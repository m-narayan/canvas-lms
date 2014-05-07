class HomePagesController < ApplicationController

  def index
    js_env :add_image_url => account_sliders_path(@domain_root_account.id)
    js_env :add_knowledge_partners_url => account_knowledge_partners_path(@domain_root_account.id)
    js_env :context_asset_string => @domain_root_account.try(:asset_string)
    js_env :account_id => @domain_root_account.id
    js_env :PERMISSIONS => {
        enable_links:  can_do((@account ||= @domain_root_account), @current_user, :manage_account_settings),
        user_logged_in: @current_pseudonym != nil
    }
    js_env :Account_Statistics => {
          users_count: @domain_root_account.users.count,
          courses_count: @domain_root_account.courses.count
          #modules_count:
          #topics_count:
    }
    js_env :account_has_sliders => @domain_root_account.account_sliders.count > 0
  end

  def add_logo
    add_header_logo_image
  end

  def add_header_logo_image
      if (folder_id = params[:header_logo].delete(:folder_id)) && folder_id.present?
        if @account
         @folder = @account.folders.active.find_by_id(folder_id)
        elsif @account
         @folder = @account.folders.active.find_by_id(folder_id)
        else
          @folder = @domain_root_account.folders.active.find_by_id(folder_id)
        end
      end
      @account ||= @domain_root_account
      @folder ||= Folder.unfiled_folder(@account)
      params[:header_logo][:uploaded_data] ||= params[:header_logo_uploaded_data]
      params[:header_logo][:uploaded_data] ||= params[:file]
      #params[:header_logo][:user] = @current_user
      params[:header_logo].delete :context_id
      params[:header_logo].delete :context_type
      duplicate_handling = params.delete :duplicate_handling
      @attachment ||= @account.attachments.build
      if authorized_action(@attachment, @current_user, :create)
        respond_to do |format|
          @attachment.folder_id ||= @folder.id
          @attachment.workflow_state = nil
          @attachment.file_state = 'available'
          success = nil
          if params[:header_logo][:uploaded_data]
            success = @attachment.update_attributes(params[:header_logo])
            @attachment.errors.add(:base, t('errors.server_error', "Upload failed, server error, please try again.")) unless success
          else
            @attachment.errors.add(:base, t('errors.missing_field', "Upload failed, expected form field missing"))
          end
            deleted_attachments = @attachment.handle_duplicates(duplicate_handling)
          if success
            if @account.account_header.nil?
              @account.build_account_header(account_id: @domain_root_account.id,header_logo_url: @attachment.id )
            else
              @prev_attachment = Attachment.find(@account.account_header.header_logo_url)
              @prev_attachment.delete
              @account.account_header.update_attributes(account_id: @domain_root_account.id,header_logo_url: @attachment.id)
            end
            @account.save
            format.html { return_to(params[:return_to], named_context_url(@account, :context_files_url))  }
            format.json do
              render_attachment_json(@attachment, deleted_attachments, @folder)
            end
            format.text do
              render_attachment_json(@attachment, deleted_attachments, @folder)
            end
          else
            format.html { render :action => "new" }
            format.json { render :json => @attachment.errors }
            format.text { render :json => @attachment.errors }
          end
        end
      end
  end


  def render_attachment_json(attachment, deleted_attachments, folder = attachment.folder)
    json = {
        :attachment => attachment.as_json(
            allow: :uuid,
            methods: [:uuid,:readable_size,:mime_class,:currently_locked,:scribdable?,:thumbnail_url],
            permissions: {user: @current_user, session: session},
            include_root: false
        ),
        :deleted_attachment_ids => deleted_attachments.map(&:id)
    }
    if folder.name == 'profile pictures'
      json[:avatar] = avatar_json(@current_user, attachment, { :type => 'attachment' })
    end

    render :json => json, :as_text => true
  end

end