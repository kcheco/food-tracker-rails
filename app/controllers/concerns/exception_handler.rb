module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :four_zero_one
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_twenty_two
  end

  private
  # JSON response with message and status code 442 - unprocessable entity
  def four_twenty_two(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end

  # JSON response with message and status code 401 - unauthorized
  def four_zero_one(e)
    render json: { message: e.message}, status: :unauthorized
  end
end
