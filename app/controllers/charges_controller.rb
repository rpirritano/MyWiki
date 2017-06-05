class ChargesController < ApplicationController
    @amount = 15_00
    
    def create
        #Amount in cents
        @amount = 15_00
        # Creates a Stripe Customer object, for associating
        # with the charge
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )
        
        # Where the real magic happens
        charge = Stripe::Charge.create(
            customer: customer.id, # Note -- this is NOT the user_id in your app
            amount: @amount,
            #amount: Amount.default,
            description: "Blocipedia Premium Membership - #{current_user.email}",
            currency: 'usd'
        )
        
        #Update user
        current_user.premium!


        flash[:notice] = "Thanks for supporting Blocipedia, #{current_user.email}! Your account has been successfully upgraded to a Premium Account."
   
         #redirect_to charges_upgraded_path(current_user)
        redirect_to edit_user_registration_path(current_user) # or wherever
 
        # Stripe will send back CardErrors, with friendly messages
        # when something goes wrong.
        # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to new_charge_path
    end


    def new
        @stripe_btn_data = {
            key: "#{ Rails.configuration.stripe[:publishable_key] }",
            description: "BigMoney Membership - #{current_user.name}",#current_user.user_name
            amount: @amount
            # amount: Amount.default
        }
    end
    
    def downgrade
        current_user.standard!
        current_user.wikis.update_all(private: false)
        redirect_to edit_user_registration_path(current_user)
        flash[:notice] = "Your account has been downgraded to a Standard Account. All Wikis are now public."
    end
    helper_method :downgrade
end