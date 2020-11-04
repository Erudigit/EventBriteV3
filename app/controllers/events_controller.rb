class EventsController < ApplicationController
    before_action :authenticate_user!, only: [:show, :new, :create]

    def index 
        @events = Event.all
    end

    def new
        @event = Event.new
    end
    
    def create
        @event = Event.create(post_params)
        @event.user = current_user
        
        if @event.save
          puts "saved"
          redirect_to events_path, :notice => 'Evenement créé'
          flash[:notive] = "Event created !"
        else
          puts "ça n'a pas fonctionne,essaie encore"
          puts @event.errors.messages
          flash.now[:alert] = "We cannot create this event for this reason(s) :"
          render 'new'
        end
    
    end

    def show 
        @event = params[:id]
        @event_id = Event.find(params[:id])
    end

    private

    def post_params
      params.permit(:title, :start_date, :description, :duration, :price, :location)
    end


end
