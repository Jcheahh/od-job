class ClaimsController < ApplicationController
  before_action :set_claim, only: [:show]

  def index
    @claims = current_user.claims.joins(:job)
  end

  def show; end

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

  def set_claim
    @claim = Claim.find(params[:id])
  end

  def claim_params
    params.permit(:job_id, :title, :pick_up_address, :drop_off_address)
  end
end
