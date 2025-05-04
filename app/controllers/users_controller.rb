class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      date = params[:date] ? Date.parse(params[:date]) : Date.today
      start_date = date.beginning_of_month
      end_date = date.end_of_month

      @users = User.all.as_json(
        only: [ :id, :name, :email, :roles ],
        methods: [ :commission, :net_profit ],
        extra_methods: {
          net_profit: ->(user) { user.net_profit(start_date, end_date) }
        }
      )
      render json: @users, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def show
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    user = User.find_by_id(params[:id]).as_json(
      only: [ :id, :name, :email, :roles ],
      methods: [ :net_profit, :commission ],
      extra_methods: {
      net_profit: ->(user) { user.net_profit(start_date, end_date) }
    })
    if user.present?
      render json: user, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end
