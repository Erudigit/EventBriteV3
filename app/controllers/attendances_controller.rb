class AttendancesController < ApplicationController

    def index 
        @attendances = Attendance.all
        @event = Event.find(attendance.event_id)
    end

    def new
        @attendance = Attendance.new
        @event = Event.find(params[:new])
        puts "**********"
        puts @event.price
        puts "**********"
        session[:price] = @event.price
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

        @attendance = Attendance.create(stripe_customer_id: "5", user_id: current_user.id, event_id: :event_id)
        
        if @attendance.save
          puts "saved"
          redirect_to events_path, :notice => 'Participation enregisté !'
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
