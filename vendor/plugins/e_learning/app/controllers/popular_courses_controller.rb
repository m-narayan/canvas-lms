class PopularCoursesController < ApplicationController

  def index
    respond_to do |format|
      @courses = []
      @account_courses = @domain_root_account.courses
      @account_courses.each_with_index do |course, idx|
        #attachment = Attachment.find(slider.account_slider_attachment_id)
        @course_image = CourseImage.find(course.id)
        @users = course.users.count
        @course_tags = course.tags.count
        image_attachment = Attachment.find(@course_image.course_image_attachment_id)
        background_image_attchment = Attachment.find(@course_image.course_back_ground_image_attachment_id)
        @course_json =   api_json(course, @current_user, session, API_USER_JSON_OPTS).tap do |json|
          json[:id] = course.id
          json[:course_name] = course.name
          json[:course_image] = file_download_url(image_attachment, { :verifier => image_attachment.uuid, :download => '1', :download_frd => '1' })
          json[:course_background_image] = file_download_url(background_image_attchment, { :verifier => background_image_attchment.uuid, :download => '1', :download_frd => '1' })
          json[:users] = @users
          json[:tags] = @course_tags
        end
        @courses << @course_json
      end
      format.json {render :json => @courses.to_json}
    end
  end
end
