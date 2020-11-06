class AttendancesController < ApplicationController

    def index 
        @guests = User.joins(:attendances).where('attendances.event_id = ?', params[:event_id])
        @event = Event.find(params[:event_id])
        @admin = User.find(@event.admin_id)
    end

    def new
        @attendance = Attendance.new
        @event = Event.find(params[:event_id])
        @admin = User.find(@event.admin_id)
        @amount = @event.price
        session[:price] = @event.price
        @guests = User.joins(:attendances).where('attendances.event_id = ?', params[:event_id])
    end

    def create
        # Amount in cents
        @amount = session[:price] * 100

        customer = Stripe::Customer.create({
            email: params[:stripeEmail],
            source: params[:stripeToken],
        })
                                         
        charge = Stripe::Charge.create({
            customer: customer.id,
            amount: @amount,
            description: 'Rails Stripe customer',
            currency: 'eur',
        })

        @attendance = Attendance.create(stripe_customer_id: params[:token], user: current_user, event: Event.find(params[:event_id]))
        
        if @attendance.save
          puts "saved"
          redirect_to event_attendances_path(Event.find(params[:event_id])), :notice => 'Participation enregisté !'
          flash[:notive] = "Participation créé !"
        else
          puts "ça n'a pas fonctionne,essaie encore"
          puts @attendance.errors.messages
          flash.now[:alert] = "We cannot create this event for this reason(s) :"
          render 'new'
        end
                                         
        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to events_path

        session.delete(:price)
    end

end
