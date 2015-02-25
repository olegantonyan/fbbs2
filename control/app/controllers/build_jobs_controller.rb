class BuildJobsController < ApplicationController
  before_filter :set_build_job, only: [:show, :update, :destroy]
  before_filter :set_enviroment
  before_filter :create_build_job, only: [:new, :enviroments]
  before_filter :set_enviroments
  before_filter :set_build_jobs, only: [:index, :enviroments]

  # GET /build_jobs
  # GET /build_jobs.json
  def index
    unless @enviroments.any?
      redirect_to enviroments_path, flash: {error: "You have to create at least one build enviroment."}  
    end
  end

  # GET /build_jobs/1
  # GET /build_jobs/1.json
  def show
  end

  # GET /build_jobs/new
  def new
  end
  
  def enviroments
  end

  # POST /build_jobs
  # POST /build_jobs.json
  def create
    branch = Branch.find(params[:build_job][:branch])
    base_version = BaseVersion.find(params[:build_job][:base_version])
    target_platform = TargetPlatform.find(params[:build_job][:target_platform])
    notify_user = User.find(params[:build_job][:notify_user])
    started_by_user = current_user
    
    @build_job = BuildJob.new(:branch => branch, 
                              :base_version => base_version, 
                              :target_platform => target_platform, 
                              :notify_user => notify_user,
                              :started_by_user => started_by_user,
                              :enviroment => @enviroment,
                              :status => BuildJob.statuses[:fresh],
                              :result => BuildJob.results[:unknown])

    respond_to do |format|
      if @build_job.save
        format.html { redirect_to home_enviroments_path, notice: 'Build job was successfully created.' }
        format.json { render :show, status: :created, location: @build_job }
      else
        format.html { render :new }
        format.json { render json: @build_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /build_jobs/1
  # DELETE /build_jobs/1.json
  def destroy
    @build_job.destroy
    respond_to do |format|
      format.html { redirect_to build_jobs_url, notice: 'Build job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # DELETE /build_jobs/1/stop
  def stop
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build_job
      @build_job = BuildJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_job_params
      params.require(:build_job).permit(:branch, :base_version, :target_platform, :notify_user, :started_by_user, :comment, :status)
    end
    
    def set_enviroment
      @enviroment = Enviroment.includes(:repository).find_by(:title => params[:enviroment_title])
      if @enviroment.nil?
        raise "Unknown build enviroment '#{params[:enviroment_title]}'. Available: #{Enviroment.all.to_a.map{|e| e.title}.join(', ')}"
        # TODO something meaningful like redirect to an error page
      end
      @users = User.order(:email => :asc).all
      @target_platforms = TargetPlatform.all
      @branches = Branch.all_filtered(@enviroment.branches_filter)
    end
    
    def set_enviroments
      @enviroments = Enviroment.all.order(:created_at => :asc)
    end
    
    def create_build_job
      @build_job = BuildJob.new(:enviroment => @enviroment)
    end
    
    def set_build_jobs
      @build_jobs = BuildJob.includes(:branch, :base_version, :target_platform).where(:enviroment => @enviroment).order(:updated_at => :desc).all
    end
    
end