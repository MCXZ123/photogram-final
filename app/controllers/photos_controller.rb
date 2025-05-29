class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]

  def index
    @photos = Photo.all
  end

  def show; end

  def new
    @photo = Photo.new
  end

  def edit; end

  def create
    @photo = Photo.new(photo_params)
    @photo.owner = current_user

    # Assign uploaded file if using a custom :image string column
    @photo.image = params[:photo][:image] if params[:photo][:image].present?

    if @photo.save
      redirect_to photo_path(@photo), notice: "Photo created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to photo_url(@photo), notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy!

    respond_to do |format|
      format.html { redirect_to photos_url, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def feed
    following_ids = current_user.sent_follow_requests.where(status: "accepted").pluck(:recipient_id)
    @feed_photos = Photo.where(owner_id: following_ids).order(created_at: :desc)
  end

  def discover
    following_ids = current_user.sent_follow_requests.where(status: "accepted").pluck(:recipient_id)
    liked_photo_ids = Like.where(fan_id: following_ids).pluck(:photo_id).uniq
    @discover_photos = Photo.where(id: liked_photo_ids).order(created_at: :desc)
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
