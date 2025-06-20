module V1
  class VehiclesController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    def create
      vehicle = Vehicle.new(vehicle_params)
      vehicles = Vehicle.all

      if vehicle.save
        render json: { status: 'success', message: 'Vehicles created successfully', vehicle: vehicle, vehicles: vehicles },
               status: :created
      else
        render json: { status: 'error', message: vehicle.errors.full_messages.join(', ') },
               status: :unprocessable_entity
      end
    end

    def vehicle_params
      params.require(:vehicle).permit(:category, :model, :make, :year, :photo)
    end

    def index
      vehicles = Vehicle.all

      render json: {
        status: 'success',
        vehicles: vehicles
      }, status: :ok
    end

    def update
      vehicle = Vehicle.find_by(id: params[:id])

      return render json: { status: 'error', message: 'Vehicle not found' }, status: :not_found unless vehicle

      if params[:photo].present?
        vehicle.photo = params[:photo]
        if vehicle.save
          vehicles = Vehicle.all
          render json: { status: 'success', vehicle: vehicle, vehicles: vehicles }, status: :ok
        else
          render json: { status: 'error', message: vehicle.errors.full_messages.join(', ') },
                 status: :unprocessable_entity
        end
      else
        render json: { status: 'error', message: 'No photo provided' }, status: :bad_request
      end
    end

    def destroy
      vehicle = Vehicle.find_by(id: params[:id])

      if vehicle
        vehicle.destroy
        render json: { status: 'success', message: 'Vehicle deleted successfully' }, status: :ok
      else
        render json: { status: 'error', message: 'Vehicle not found' }, status: :not_found
      end
    end
  end
end
