class JobOpportunitiesController < ApplicationController
  def index
    job_opportunities = JobOpportunity.jobs_for_student(user_session.current_user)
    render :index, locals: {job_opportunities: job_opportunities}
  end

  def create
    job_parameters = params.require(:job_opportunity).permit!
    job_opportunity = JobOpportunity.new(job_parameters)
    job_opportunity.user_id = user_session.current_user.id
    if job_opportunity.save
      flash[:notice] = 'Job Opportunity Successfully Created'
    else
      flash[:notice] = 'Sorry, something went wrong!'
    end
    redirect_to action: :index
  end

  def show
    job_opportunity = JobOpportunity.find(params[:id])
    render 'show', locals: {
      job_opportunity: job_opportunity
    }
  end

  def edit
    job_opportunity = JobOpportunity.find(params[:id])
    render 'edit', locals: {
      job_opportunity: job_opportunity
    }
  end

  def update
    job_opportunity = JobOpportunity.find(params[:id])
    job_parameters = params.require(:job_opportunity).permit!
    job_opportunity.update(job_parameters)
    redirect_to action: :show
  end

  def destroy
    job_opportunity = JobOpportunity.find(params[:id])
    job_opportunity.destroy
    redirect_to action: :index
  end
end