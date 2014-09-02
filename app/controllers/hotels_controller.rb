class HotelsController < ApplicationController
  before_action :set_hotel, only: [:edit, :update, :destroy]
  before_action :config_expedia, only: [:index, :show]

  # GET /hotels
  # GET /hotels.json
  def index

    response = @api.get_list({:destinationString => 'Media', :stateProvinceCode => 'PA'})
    @hotels = response.body['HotelListResponse']['HotelList']['HotelSummary']

  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
    response = @api.get_list({:hotelId => @hotel_id, :destinationString => 'Media'})
    @hotel = response.body['HotelListResponse']['HotelList']['HotelSummary'][0]
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to @hotel, notice: 'Hotel was successfully created.' }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel_id = params[:id]
    end

    def config_expedia

      Expedia.cid = 55505
      Expedia.api_key = 'yt2mfcm9eua5dydntsd477qs'
      Expedia.shared_secret = 'Z7ctwvaN'
      Expedia.locale = 'en_US'
      Expedia.currency_code = 'USD'
      Expedia.minor_rev = 13
      @api = Expedia::Api.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params[:hotel]
    end
end
