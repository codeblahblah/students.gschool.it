class ApplicationsController < ApplicationController
 def new

 end

  def create
    @application = Application.new(application_params)
    if @application.save
      flash[:notice] = "You have successfully applied!"
      redirect_to job_dashboard_path
    else
      render :new
    end
  end


 private

 def application_params
   params.require(:application).
     permit(:resume, :user_id).
     merge(job_opportunity_id: params[:job_opportunity_id])
 end
end