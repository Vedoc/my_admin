module V1
  class ServiceRequestsController < BaseApiController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    before_action :set_service_request, only: [:destroy]

    def create
      permitted_params = service_request_params

      loc = params.dig(:service_request, :location)

      if loc.present?
        lat = loc[:lat].to_f
        long = loc[:long].to_f

        if (lat.zero? && (loc[:lat].to_s.strip != '0' && loc[:lat].to_s.strip != '0.0')) ||
           (long.zero? && (loc[:long].to_s.strip != '0' && loc[:long].to_s.strip != '0.0'))
          @service_request = ServiceRequest.new
          @service_request.errors.add(:location, 'latitude or longitude are invalid numbers.')
          render json: { errors: @service_request.errors.full_messages }, status: :unprocessable_entity and return
        end

        rgeo_point = RGeo::Geographic.spherical_factory(srid: 4326).point(long, lat)

        permitted_params[:location] = rgeo_point
      else

        permitted_params[:location] = nil
      end

      @service_request = ServiceRequest.new(permitted_params)

      if @service_request.save
        json_serialization_options = {
          include: %i[vehicle photos videos],
          methods: [:parsed_location]
        }
        service_requests = ServiceRequest.all.as_json(json_serialization_options)
        render json: { status: 'success', message: 'Service request created successfully', service_request: @service_request.as_json(json_serialization_options), service_requests: service_requests },
               status: :created
      else

        render json: { status: 'error', message: @service_request.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def index
      all_or_filtered_service_requests = ServiceRequest.includes(:vehicle)
      first_matching_service_request = nil

      if params[:title].present?
        search_query = params[:title]
        all_or_filtered_service_requests = all_or_filtered_service_requests
                                           .where('summary ILIKE ? OR title ILIKE ?', "%#{search_query}%", "%#{search_query}%")

        first_matching_service_request = all_or_filtered_service_requests.first

      end

      format_service_request_with_vehicle = lambda do |sr|
        return nil unless sr

        sr.as_json(
          include: %i[vehicle photos videos]
        )
      end

      formatted_service_requests_list = all_or_filtered_service_requests.map(&format_service_request_with_vehicle)
      formatted_single_service_request = format_service_request_with_vehicle.call(first_matching_service_request)

      response_data = {
        status: 'success',
        service_requests: formatted_service_requests_list,
        service_request: formatted_single_service_request
      }

      render json: response_data, status: :ok
    end

    def destroy
      if @service_request.destroy
        render json: { message: 'Service request deleted successfully', status: 'success' }, status: :ok
      else
        render json: { message: @service_request.errors.full_messages, status: 'error' }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { error: "An unexpected error occurred during deletion: #{e.message}", status: 'error' },
             status: :internal_server_error
    end

    def show
      @service_request = ServiceRequest.find_by(id: params[:id])
      json_serialization_options = {
        include: :vehicle,
        methods: [:parsed_location]
      }

      all_service_requests_json = ServiceRequest.all.as_json(json_serialization_options)

      if @service_request
        render json: {
          status: 'success',
          service_requests: all_service_requests_json,
          service_request: @service_request.as_json(json_serialization_options)
        }, status: :ok
      else
        render json: {
          status: 'error',
          message: "Service request not found with ID: #{params[:id]}",
          service_requests: all_service_requests_json,
          service_request: nil
        }, status: :not_found
      end
    rescue ActiveRecord::RecordNotFound
      render json: {
        status: 'error',
        message: "Service request not found with ID: #{params[:id]}",
        service_requests: ServiceRequest.all.as_json(json_serialization_options),
        service_request: nil
      }, status: :not_found
    rescue StandardError => e
      render json: {
        status: 'error',
        message: "An unexpected error occurred: #{e.message}",
        service_requests: [],
        service_request: nil
      }, status: :internal_server_error
    end

    def car_makes
      vehicles_query = Vehicle.all

      if params[:category].present?
        search_category = params[:category].downcase

        vehicles_query = vehicles_query.where(
          Vehicle.arel_table[:category].lower.eq(search_category)
        )
      end

      car_makes = vehicles_query.pluck(Arel.sql('DISTINCT TRIM(LOWER(make))'))

      car_makes.map!(&:capitalize)

      render json: { status: 'success', car_makes: car_makes }, status: :ok
    rescue StandardError => e
      render json: {
        status: 'error',
        message: "An unexpected error occurred: #{e.message}"
      }, status: :internal_server_error
    end

    def car_models
      vehicles_query = Vehicle.all

      if params[:car_make].present?
        search_make = params[:car_make].downcase.strip

        normalized_make_column = Arel::Nodes::NamedFunction.new('LOWER', [
                                                                  Arel::Nodes::NamedFunction.new('TRIM', [
                                                                                                   Vehicle.arel_table[:make]
                                                                                                 ])
                                                                ])
        vehicles_query = vehicles_query.where(normalized_make_column.eq(search_make))
      end

      car_models = vehicles_query.pluck(Arel.sql('DISTINCT TRIM(LOWER(model))'))
      car_models.map!(&:capitalize)

      render json: { status: 'success', car_models: car_models }, status: :ok
    rescue StandardError => e
      render json: { status: 'error', message: "An unexpected error occurred: #{e.message}" },
             status: :internal_server_error
    end

    def model_years
      vehicles_query = Vehicle.all

      if params[:car_model].present?
        search_model = params[:car_model].downcase.strip
        vehicles_query = vehicles_query.where(Vehicle.arel_table[:model].lower.eq(search_model))
      end

      model_years = vehicles_query.distinct.pluck(:year)
      model_years.sort!

      render json: { status: 'success', car_model_years: model_years }, status: :ok
    rescue StandardError => e
      render json: {
        status: 'error',
        message: "An unexpected error occurred: #{e.message}"
      }, status: :internal_server_error
    end

    def settings_index
      settings_hash = {}

      Setting.all.each do |setting|
        settings_hash[setting.var] = setting.value
      end

      render json: {
        status: 'success',
        settings: settings_hash
      }, status: :ok
    rescue StandardError => e
      render json: {
        status: 'error',
        message: "An unexpected error occurred while fetching settings: #{e.message}",
        settings: {}
      }, status: :internal_server_error
    end

    private

    def set_service_request
      @service_request = ServiceRequest.find(params[:id])
    end

    def assign_location(service_request)
      loc = params.dig(:service_request, :location)
      return if loc.blank?

      lat = loc[:lat] || loc['lat']
      long = loc[:long] || loc['long']

      return if lat.blank? || long.blank?

      service_request.location = RGeo::Geographic.spherical_factory(srid: 4326).point(long, lat)
    end

    def service_request_params
      params.require(:service_request).permit(
        :mileage, :category, :summary, :evacuation, :radius, :vin,
        :repair_parts, :vehicle_id, :schedule_service, :title,
        :estimated_budget, :address,
        photos_attributes: [:data],
        videos_attributes: [:data]
      )
    end
  end
end
