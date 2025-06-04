# app/controllers/api/promotions_controller.rb
module Api
  class PromotionsController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      promotion = Promotion.new(promotion_params)
      if promotion.save
        render json: { success: true, promotion: promotion }, status: :created
      else
        render json: { success: false, errors: promotion.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def promotion_params
      params.require(:promotion).permit(:first_name, :last_name, :email, :phone_number, :car_needs)
    end
  end
end
