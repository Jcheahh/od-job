class ClaimsController < ApplicationController
  def index
    @claims = current_user.claims.joins(:job)
  end

  def create
    @job = Job.find(claim_params[:job_id])
    if @job.user_id != current_user.id
      @claim = current_user.claims.create!(claim_params)

      redirect_to jobs_path
    else
      flash[:danger] = "Cannot claim your own job!"

      redirect_to @job
    end
  end

  private

  def claim_params
    params.permit(:job_id)
  end
end
