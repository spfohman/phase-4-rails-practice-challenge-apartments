class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index 
        apartments = Apartment.all 
        render json: apartments, status: :ok 
    end
    def show
        apartment = find_apartment 
        render json: apartment, status: :ok 
    end
    def create 
        apartment = Apartment.create(apartment_params)
        render json: apartment, status: :created 
    end 
    def destroy 
        apartment = find_apartment 
        if apartment 
            apartment.destroy 
            head :no_content 
        else  
            render_not_found_response 
        end
    end

    private 
    def apartment_params 
        params.permit(:number)
    end
    def find_apartment 
        Apartment.find_by(id: params[:id])
    end 
    def render_not_found_response 
        render json: {error: "Apartment not found"}, status: :not_found 
    end
end
