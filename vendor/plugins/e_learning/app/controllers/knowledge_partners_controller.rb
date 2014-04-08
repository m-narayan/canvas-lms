class KnowledgePartnersController < ApplicationController

  before_filter :require_context

  def create
    @knowledge_partner =  KnowledgePartner.new(account_id:params['account_id'],partners_info:params['partners_info'])
    response_to do |format|
      if @knowledge_partner.save
        format.json { render :json => @knowledge_partner.to_json}
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
