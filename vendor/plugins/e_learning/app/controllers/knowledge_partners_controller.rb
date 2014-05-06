class KnowledgePartnersController < ApplicationController

  before_filter :require_context

  def create
   add_knowledge_partners
  end

  def add_knowledge_partners
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

  def destroy
    @knowledge_partner = KnowledgePartner.find(params[:id])
    respond_to do |format|
      if  @knowledge_partner.destroy
        format.json { render :json =>  @knowledge_partner }
      else
        format.json { render :json =>  @knowledge_partner.errors.to_json, :status => :bad_request }
      end
    end
  end

end
