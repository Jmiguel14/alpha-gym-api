require "pry"

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @users = User.all.as_json(
        only: [ :id, :name, :email, :roles ]
      )
      render json: @users, status: :ok
    else
      @users = User.where(id: current_user.id).as_json(
        only: [ :id, :name, :email, :roles ]
      )
      render json: @users, status: :ok
    end
  end

  def show
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    start_date = date.beginning_of_month
    end_date = date.end_of_month

    user = User.find_by(id: params[:id])

    if user.present?
      user_data = user.as_json(
        only: [ :id, :name, :email, :roles ]
      ).merge(
        net_profit: user.net_profit(start_date, end_date),
        commission: user.commission(start_date, end_date)
      )
      render json: user_data, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end
