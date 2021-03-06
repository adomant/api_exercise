class CommitsController < ApplicationController
  before_action :set_commit, only: [:show, :edit, :update, :destroy]

  # GET /commits
  # GET /commits.json
  def index
    Commit.load(search_params) if search_params.present?
    @commits = Commit.all.page params[:page]
  end

  # GET /commits/1
  # GET /commits/1.json
  def show
  end

  # GET /commits/new
  def new
    @commit = Commit.new
  end

  # GET /commits/1/edit
  def edit
  end

  # POST /commits
  # POST /commits.json
  def create
    @commit = Commit.new(commit_params)

    respond_to do |format|
      if @commit.save
        format.html { redirect_to @commit, notice: 'Commit was successfully created.' }
        format.json { render :show, status: :created, location: @commit }
      else
        format.html { render :new }
        format.json { render json: @commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commits/1
  # PATCH/PUT /commits/1.json
  def update
    respond_to do |format|
      if @commit.update(commit_params)
        format.html { redirect_to @commit, notice: 'Commit was successfully updated.' }
        format.json { render :show, status: :ok, location: @commit }
      else
        format.html { render :edit }
        format.json { render json: @commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commits/1
  # DELETE /commits/1.json
  def destroy
    @commit.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to commits_url }
    end
  end

  def destroy_multiple
    Commit.where(:id => params[:commit_ids]).delete_all
    respond_to do |format|
      format.js
      format.html { redirect_to commits_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commit
      @commit = Commit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commit_params
      params.require(:commit).permit(:commiter_name, :commiter_email, :message, :commit_url, :profile_url, :commit_date)
    end
    def search_params
      params.permit(:owner, :repo, :author_email)
    end
end
