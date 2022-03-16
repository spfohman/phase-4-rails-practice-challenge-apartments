class TenantsController < ApplicationController
    
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
        def index 
            tenants = Tenant.all 
            render json: tenants, status: :ok 
        end
        def show
            tenant = find_tenant 
            render json: tenant, status: :ok 
        end
        def create 
            tenant = Tenant.create(tenant_params)
            render json: tenant, status: :created 
        end 
        def destroy 
            tenant = find_tenant 
            if tenant 
                tenant.destroy 
                head :no_content 
            else  
                render_not_found_response 
            end
        end
    
        private 
        def tenant_params 
            params.permit(:name, :age)
        end
        def find_tenant 
            Tenant.find_by(id: params[:id])
        end 
        def render_not_found_response 
            render json: {error: "Tenant not found"}, status: :not_found 
        end
    
    
end
