class SpotsController < ApplicationController
  layout 'application_full_width', only: [:location]
  before_action :require_user_logged_in, only: [:new, :create, :edit, :updeate, :destroy]
  before_action :set_spot, only: [:show, :edit, :update, :destroy, :reviews]
  
  def index
    @spots = Spot.all.order('created_at DESC')
  end

  def new
    @spot = Spot.new
    @spot.category_spots.build
  end

  def show
    @reviews = @spot.reviews.order('created_at DESC')
  end

  def create
    @spot = current_user.spots.build(spot_params)
    
    zipcode = spot_params[:zipcode]
    address = JpZipCode.search zipcode
    @spot.pref = address['pref_kanji']
    @spot.city = address['city_kanji']
    @spot.town = address['town_kanji']
    
    if @spot.save
      flash[:success] = '登録しました'
      redirect_to @spot
    else
      render :new
    end
    
  end

  def edit
  end
  
  def update
    if @spot.update(spot_params)
      flash[:success] = 'スポット情報を変更しました'
      redirect_to @spot
    else
      render :edit
    end
  end
  
  def destroy
    @spot.destroy
    flash[:success] = 'スポットを削除しました'
    redirect_to spots_url
  end
  
  def prefs
    @prefs = JpPrefecture::Prefecture.all
  end
  
  def pref
    @spots = Spot.where(pref: params[:pref])
    @pref = JpPrefecture::Prefecture.find name: params[:pref]
    @prefname = @pref.name
  end
  
  def location
    @spots = Spot.order('created_at DESC')
    
    if params[:lat].present?
      lat = params[:lat]
      lng = params[:lng]
      latlag = [lat, lng]
      @spots = @spots.near(latlag, 2, units: :km)
    else
      @spots = Spot.order('created_at DESC')
    end
    
    if params[:distance].present?
      lat = params[:lat]
      lng = params[:lng]
      latlag = [lat, lng]
      distance = params[:distance]
      @spots = @spots.near(latlag, distance, units: :km)
    end
    
    if params[:category_id].present?
      @spots = @spots.includes(:categories).where(categories: { id: params[:category_id] })
    end
    
    @json_data = @spots.select(:name, :latitude, :longitude).to_json.html_safe
    
    p @json_data
    
  end

  def reviews
    @reviews = @spot.reviews.order('created_at DESC')
  end
  
  private
  
  def set_spot
    @spot = Spot.find(params[:id])
  end
  
  def spot_params
    params.require(:spot).permit(:name, :kana, :address, :access, :phone, :zipcode, :pref, :city, :town, :latitude, :longitude, :overview, :image, { :category_ids=> []})
  end
  
end
