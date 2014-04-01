class AccountSlidersController < ApplicationController
  before_filter :get_context

  def index
    respond_to do |format|
      @account_sliders = @context.account_sliders
      format.json {render :json => @account_sliders.map(&:attributes).to_json}
    end
  end

  def create
    add_course_image
  end

  def edit

  end

  def update
    add_course_image
  end

  def destroy

  end

  def add_course_image
     if (folder_id = params[:attachment].delete(:folder_id)) && folder_id.present?
       @folder = @context.folders.active.find_by_id(folder_id)
     end
     @folder ||= Folder.unfiled_folder(@context)
     params[:attachment][:uploaded_data] ||= params[:attachment_uploaded_data]
     params[:attachment][:uploaded_data] ||= params[:file]
     params[:attachment][:user] = @current_user
     params[:attachment].delete :context_id
     params[:attachment].delete :context_type
     duplicate_handling = params.delete :duplicate_handling
     @attachment ||= @context.attachments.build
     if authorized_action(@attachment, @current_user, :create)
       get_quota
       return if (params[:check_quota_after].nil? || params[:check_quota_after] == '1') &&
           quota_exceeded(named_context_url(@context, :context_files_url))

       respond_to do |format|
         @attachment.folder_id ||= @folder.id
         @attachment.workflow_state = nil
         @attachment.file_state = 'available'
         success = nil
         if params[:attachment][:uploaded_data]
           success = @attachment.update_attributes(params[:attachment])
           @attachment.errors.add(:base, t('errors.server_error', "Upload failed, server error, please try again.")) unless success
         else
           @attachment.errors.add(:base, t('errors.missing_field', "Upload failed, expected form field missing"))
         end
         deleted_attachments = @attachment.handle_duplicates(duplicate_handling)
         if success
           if (params[:course_image_upload] == "back_ground_image")
             @context.back_ground_image_url=course_file_preview_path(@context,@attachment)
           elsif(params[:course_image_upload] == "image")
             @context.image_url=course_file_preview_path(@context,@attachment)
           end
           @context.save
           format.html { return_to(params[:return_to], named_context_url(@context, :context_files_url)) }
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