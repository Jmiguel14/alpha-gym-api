# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def respond_to_on_failure
    render json: {
      status: {
        code: 401,
        message: 'Invalid login credentials.'
      }
    }, status: :unauthorized
  end

  private

  def respond_with(resource, _opt = {})
    if resource.persisted?
      @token = request.env['warden-jwt_auth.token']
      headers['Authorization'] = @token

      render json: {
        status: {
          code: 200, message: 'Logged in successfully.',
          token: @token,
          data: {
            user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }
        }
      }, status: :ok
    else
      respond_to_on_failure
    end
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first

      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
