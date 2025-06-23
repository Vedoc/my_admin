module V1
  class BaseApiController < ApplicationController
    skip_before_action :verify_authenticity_token

    before_action :authenticate_request!

    attr_reader :current_user

    private

    def authenticate_request!
      header = request.headers['Authorization']
      token = header.split(' ').last if header && header.starts_with?('Bearer ')

      if token.present?
        begin
          decoded_token = JWT.decode(token, JWT_SECRET_KEY, true, algorithm: JWT_ALGORITHM)
          user_id = decoded_token[0]['user_id']

          @current_user = User.find(user_id)
        rescue JWT::VerificationError
          render json: { errors: ['Invalid JWT signature.'] }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: ["Invalid token: #{e.message}"] }, status: :unauthorized
        rescue JWT::ExpiredSignature
          render json: { errors: ['Token has expired. Please sign in again.'] }, status: :unauthorized
        rescue ActiveRecord::RecordNotFound
          render json: { errors: ['User not found. Invalid token.'] }, status: :unauthorized
        rescue StandardError => e
          Rails.logger.error("Authentication Error: #{e.message}\n#{e.backtrace.join("\n")}")
          render json: { errors: ['An unexpected authentication error occurred.'] }, status: :internal_server_error
        end
      else
        render json: { errors: ['Authorization header is missing or malformed (e.g., "Bearer Token").'] },
               status: :unauthorized
      end
    end
  end
end
