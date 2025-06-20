module V1
  class AuthController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    def create
      ActiveRecord::Base.transaction do
        user = User.new(user_params)
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity and return unless user.save

        lat = shop_params[:location_lat].to_f
        lon = shop_params[:location_long].to_f
        unless lat.between?(-90.0, 90.0) && lon.between?(-180.0, 180.0)
          raise ArgumentError, 'Invalid latitude or longitude provided.'
        end

        location_point = RGeo::Geographic.spherical_factory(srid: 4326).point(lon, lat)

        shop_creation_params = shop_params.except(:location_lat, :location_long,
                                                  :photo).merge(location: location_point)

        shop = user.build_shop(shop_creation_params)

        render json: { errors: shop.errors.full_messages }, status: :unprocessable_entity and return unless shop.save

        if params[:shop][:photo].present?
          uploaded_files = []
          params[:shop][:photo].each do |photo_hash|
            if photo_hash.is_a?(ActionController::Parameters) && photo_hash[:data].present?
              uploaded_files << photo_hash[:data]
            elsif photo_hash.is_a?(ActionDispatch::Http::UploadedFile)
              uploaded_files << photo_hash
            end
          end

          shop.photos.attach(uploaded_files) if uploaded_files.any?
        end

        device = user.devices.new(device_params)
        unless device.save
          render json: { errors: device.errors.full_messages }, status: :unprocessable_entity and return
        end

        render json: { message: 'Business signup successful', user_id: user.id, shop_id: shop.id },
               status: :created
      rescue ArgumentError => e
        render json: { errors: ["Invalid input provided: #{e.message}"] }, status: :bad_request
      rescue ActiveRecord::RecordNotUnique => e
        error_message = e.message.split('DETAIL:').last.strip
        render json: { errors: ["A record with this unique identifier already exists: #{error_message}"] },
               status: :conflict
      rescue StandardError => e
        Rails.logger.error("Error during business signup: #{e.message}\n#{e.backtrace.join("\n")}")
        render json: { errors: ['An unexpected error occurred during signup.'] }, status: :internal_server_error
      end
    end

    private

    def user_params
      params.permit(:email, :password)
    end

    def shop_params
      params.require(:shop).permit(
        :name, :owner_name, :hours_of_operation, :techs_per_shift,
        :lounge_area, :supervisor_permanently, :complimentary_inspection,
        :vehicle_warranties, :vehicle_diesel, :vehicle_electric,
        :certified, :tow_track, :address, :phone, :facebook, :instagram,
        :hiring_email, :stripe_token, :approved, :avatar, :additional_info, :average_rating,
        categories: [],
        languages: [],
        location: %i[lat long],
        photo: [:data]
      ).tap do |whitelisted|
        if whitelisted[:location].present?
          whitelisted[:location_lat] = whitelisted[:location][:lat]
          whitelisted[:location_long] = whitelisted[:location][:long]
          whitelisted.delete(:location)
        end

        whitelisted.delete(:photo) if whitelisted[:photo].present?
      end
    end

    def device_params
      params.require(:device).permit(:platform, :device_id, :device_token)
    end
  end
end
