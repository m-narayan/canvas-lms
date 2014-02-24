class CourseDescriptionsController < ApplicationController
  before_filter :require_context

  def create
   @course_desc = CourseDescription.new(course_id:params['course_id'],course_description:params['course_description']['description'])
   @course_desc.account_id=Course.find_by_account_id(@context.account_id).id
   respond_to do |format|
     if @course_desc.save
       flash[:notice] = t('description_created', "Description successfully created!")
       format.html { redirect_to course_settings_url(@context) }
       format.json { render :json =>  @course_desc.to_json }
     else
       flash[:error] = t('description_creation_failed', "Save Failed")
       format.html { redirect_to course_settings_url(@context) }
       format.json { render :json =>  @course_desc.errors, :status =>:error}
     end
   end
  end
  end

