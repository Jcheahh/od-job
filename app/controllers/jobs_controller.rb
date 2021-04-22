class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :destroy]

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def show; end

  def create
    @job = current_user.jobs.create!(job_params)

    redirect_to jobs_path
  end

  def destroy
    @job = current_user.jobs.find(params[:id])
    if @job.claim.nil?
      @job.destroy

      redirect_to jobs_path
    else
      flash[:danger] = "This job is claimed"

      redirect_to @job
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :pick_up_address, :drop_off_address, :pick_up_latitude, :pick_up_longtitude, :drop_off_latitude,
                                :drop_off_longtitude)
  end
end
