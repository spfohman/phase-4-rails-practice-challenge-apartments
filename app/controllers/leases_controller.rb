class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # def index 
    #     leases = Lease.all 
    #     render json: leases, status: :ok 
    # end
    # def show
    #     lease = find_lease 
    #     render json: lease, status: :ok 
    # end
    def create 
        lease = Lease.create(lease_params)
        render json: lease, status: :created 
    end 
    def destroy 
        lease = find_lease 
        if lease 
            lease.destroy 
            head :no_content 
        else  
            render_not_found_response 
        end
    end

    private 
    def lease_params 
        params.permit(:rent, :apartment_id, :tenant_id)
    end
    def find_lease 
        Lease.find_by(id: params[:id])
    end 
    def render_not_found_response 
        render json: {error: "Lease not found"}, status: :not_found 
    end
end
