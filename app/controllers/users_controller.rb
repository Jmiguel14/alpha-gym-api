class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @users = User.all.as_json(only: [ :id, :name, :email, :roles ], methods: [ :net_profit, :commission ])
      puts "users: #{@users}"
      render json: @users, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def show
    user = User.find_by_id(params[:id]).as_json(only: [ :id, :name, :email, :roles ], methods: [ :net_profit, :commission ])
    if user.present?
      render json: user, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end
