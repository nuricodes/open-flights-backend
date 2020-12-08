module Api 
    module V1
        class AirlinesController < ApplicationController
            protect_from_forgery with: :null_session
            def index 
                #get all the airlines from our database 
                airlines = Airline.all
                
                #user airline serializer to pass that as a value and convert to serialed json
                render json: AirlineSerializer.new(airlines, options).serialized_json
            end
            #same thing but with individualized airline find by slug param
            def show
                airline = Airline.find_by(slug: params[:slug])
                #pass in individual airline
                render json: AirlineSerializer.new(airline, options).serialized_json
            end
            
            def create
                airline = Airline.new(airline_params)

                if airline.save #if we're able to save the record and everything is valid
                    render json: AirlineSerializer.new(airline).serialized_json
                else 
                    render json: {error: airline.errors.messages}, status: 422
                end
            end

            def update
                #instead of creating new instance of method do findby
                airline = Airline.find_by(slug: params[:slug])

                if airline.update(airline_params) #if we're able to save the record and everything is valid
                    render json: AirlineSerializer.new(airline, options).serialized_json
                else 
                    render json: {error: airline.errors.messages}, status: 422
                end
            end

            def destroy
                #instead of creating new instance of method do findby
                airline = Airline.find_by(slug: params[:slug])

                if airline.destroy
                    head :no_content
                else 
                    render json: {error: airline.errors.messages}, status: 422
                end
            end
            #creates strong parameters
            private
            #creates a white list of the parametes we want to allow and permits them
            def airline_params
                params.require(:airline).permit(:name, :img_url)
            end
            def options
                #instance variable equal to a hash and specify the resources we want to include whichis reviews
                @options ||= {include: %i[reviews]}
            end
        end
    end
end