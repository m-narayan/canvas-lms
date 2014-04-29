class PopularCoursesController < ApplicationController

  def index
    respond_to do |format|
      @courses = []
      @total_tags = []
      @account_courses = @domain_root_account.courses
      @account_courses.each_with_index do |course, idx|
        #attachment = Attachment.find(slider.account_slider_attachment_id)
        @course_image = CourseImage.find(course.id)
        @users_count = course.users.count
        @course_tags_count = course.tags.count
        @course_tags = course.tags
        if course.course_description
          @course_desc = CourseDescription.find(course.id)
          @short_course_desc = @course_desc.long_description
        end
        @course_tags.each_with_index do |tag, id|

          @total_tags << tag
        end
        image_attachment = Attachment.find(@course_image.course_image_attachment_id)
        background_image_attchment = Attachment.find(@course_image.course_back_ground_image_attachment_id)
        @course_json =   api_json(course, @current_user, session, API_USER_JSON_OPTS).tap do |json|
          json[:id] = course.id
          json[:course_name] = course.name
          json[:course_image] = file_download_url(image_attachment, { :verifier => image_attachment.uuid, :download => '1', :download_frd => '1' })
          json[:course_background_image] = file_download_url(background_image_attchment, { :verifier => background_image_attchment.uuid, :download => '1', :download_frd => '1' })
          json[:users_count] = @users_count
          json[:tags_count] = @course_tags_count
          json[:course_tags] = @total_tags
          json[:course_short_decription] = @short_course_desc
        end
        @total_tags = []
        @courses << @course_json
      end
      format.json {render :json => @courses.to_json}
    end
  end


end
