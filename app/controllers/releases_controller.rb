class ReleasesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show]
  autocomplete :artist, :name
  
  # GET /releases
  # GET /releases.json
  def index
    @releases = Release.published.paginate(:page => params[:page], :per_page => 9)
    @releases_all = Release.paginate(:page => params[:page], :per_page => 25)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @releases }
    end
  end

  # GET /releases/1
  # GET /releases/1.json
  def show
    @release = Release.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @release }
    end
  end

  # GET /releases/new
  # GET /releases/new.json
  def new
    @release = Release.new
    @artists = Artist.order(:name)
    1.times { @release.tracks.build }
    respond_to do |format| 
      format.html # new.html.erb
      format.json { render json: @release }
    end
  end

  # GET /releases/1/edit
  def edit
    @release = Release.find(params[:id])
  end

  # POST /releases
  # POST /releases.json
  def create
    @release = Release.new(params[:release])
    
    respond_to do |format|
      if @release.save
        @release.tag_tracks
        @release.add_default_zip
        format.html { redirect_to @release, notice: 'Release was successfully created.' }
        format.json { render json: @release, status: :created, location: @release }
      else
        format.html { render action: "new" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /releases/1
  # PUT /releases/1.json
  def update
    @release = Release.find(params[:id])
    
    respond_to do |format|
      if @release.update_attributes(params[:release])
        @release.tag_tracks
        @release.add_default_zip
        format.html { redirect_to @release, notice: 'Release was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    @release = Release.find(params[:id])
    @release.destroy

    respond_to do |format|
      format.html { redirect_to releases_url }
      format.json { head :no_content }
    end
  end
end
