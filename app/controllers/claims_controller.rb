class ClaimsController < ApplicationController
  before_action :set_claim, only: [:show]

  def index
    @claims = Claim.all
  end

  def show; end

  def create
    @claim = current_user.claims.create!(claim_params)

    redirect_to jobs_path
  end

  private

  def set_claim
    @claim = Claim.find(params[:id])
  end

  def claim_params
    params.permit(:job_id, :title, :pick_up_address, :drop_off_address)
  end
end
