class MediaCollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :get_image, :availables]

  def availables
    authorize! :availables, MediaCollection
    @media_collections = MediaCollection.where(available: 1).decorate
  end


  # GET /media_collections
  # GET /media_collections.json
  def index
    authorize! :index, MediaCollection
    @media_collections = current_user.media_collections.decorate
  end

  # GET /media_collections/1
  # GET /media_collections/1.json
  def show
    @media_collection = MediaCollection.find(params[:id]).decorate
    authorize! :show, @media_collection
  end

  # GET /media_collections/new
  def new
    @media_collection = MediaCollection.new
    @media_collection.images.build
    @media_collection.urls.build
  end

  # GET /media_collections/1/edit
  def edit
    @media_collection = MediaCollection.find(params[:id]).decorate
    authorize! :edit, @media_collection
  end

  # POST /media_collections
  # POST /media_collections.json
  def create
    @media_collection = MediaCollection.new(media_collection_params)
    @media_collection.user_id = current_user.id

    respond_to do |format|
      if @media_collection.save
        format.html { redirect_to @media_collection, notice: 'Медиа коллекция успешно создана.' }
        format.json { render :show, status: :created, location: @media_collection }
      else
        format.html { render :new }
        format.json { render json: @media_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_collections/1
  # PATCH/PUT /media_collections/1.json
  def update
    @media_collection = MediaCollection.find(params[:id])
    authorize! :update, @media_collection

    respond_to do |format|
      if @media_collection.update(media_collection_params)
        format.html { redirect_to @media_collection, notice: 'Медиа коллекция успешно обновлена.' }
        format.json { render :show, status: :ok, location: @media_collection }
      else
        format.html { render :edit }
        format.json { render json: @media_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_collections/1
  # DELETE /media_collections/1.json
  def destroy
    @media_collection = MediaCollection.find(params[:id])
    @media_collection.destroy

    authorize! :destroy, @media_collection

    respond_to do |format|
      format.html { redirect_to media_collections_url, notice: 'Медиа коллекция успешно удалена.' }
      format.json { head :no_content }
    end
  end

  def get_image

    image = Image.find(params[:id])

    if params[:version]
      image_url = File.join('public', image.image.send(params[:version]).url)
    else
      image_url = File.join('public', image.image.url)
    end


    @media_collection = image.media_collection

    if can? :show, @media_collection

      if File.exist? image_url

        send_file image_url, type: image.image.content_type, disposition: 'inline'
      else

        render text: "Нет доступа или файл не найден. #{image_url}", :status => 404
      end

    else
      render text: 'Нет доступа или файл не найден.', :status => 404
    end

  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_collection_params
      params.require(:media_collection).permit(:user_id, :name, :available,
                                               images_attributes: [:image, :name, :media_collection_id, :id, :_destroy],
                                               urls_attributes: [:name, :url, :media_collection_id, :id, :_destroy])
    end
end
