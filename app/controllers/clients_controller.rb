class ClientsController < ApplicationController
 before_action :authenticate_user!

 def index
    @clients = Client.all
    render json: { clients: @clients }, status: :ok
 end
end
