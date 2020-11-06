class EventsController < ApplicationController
    before_action :authenticate_user!, only: [:show, :new, :create]

    def index 
        @events = Event.all
    end

    def new
        @event = Event.new
    end
    
    def create
        @event = Event.new(title: params[:title], 
        description: params[:description],
        location: params[:location],
        price: params[:price],
        start_date: params[:start_date],
        duration: params[:duration],
        admin_id: current_user.id)

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
        @event = Event.find(params[:id])
        @user = User.find(@event.admin_id)
        @attendance = Attendance.all
        @guests = User.joins(:attendances).where('attendances.event_id = ?', params[:event_id])
    end
end