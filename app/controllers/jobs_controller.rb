class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:destroy]

  def index
    lat = params[:lat] || "3.1466"
    lng = params[:lng] || "101.6958"
    @jobs = Job.joins(:user).near("#{lat},#{lng}", 60).order(:distance)
  end

  def mine
    @job = current_user.jobs
  end

  def new
    @job = Job.new
  end

  def show
    @job = Job.left_outer_joins(:claim).select("jobs.*, (claims.job_id IS NOT NULL) AS claimed").find(params[:id])
  end

  def create
    @job = current_user.jobs.create(job_params)

    if @job.valid?
      redirect_to jobs_path
    else
      flash[:danger] = @job.errors.full_messages.join("\n")

      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @job = current_user.jobs.find(params[:id])

    if @job.claim.nil?
      @job.destroy

      redirect_to jobs_path
    else
      flash[:danger] = "This job is claimed"

      render :show, status: :method_not_allowed
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :pick_up_address, :drop_off_address, :pick_up_latitude, :pick_up_longitude, :drop_off_latitude,
                                :drop_off_longitude)
  end
end
