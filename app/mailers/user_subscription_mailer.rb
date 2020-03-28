class UserSubscriptionMailer < ApplicationMailer
    default from: 'csc517.niram@gmail.com'
 
    def subscription_email
      @user = params[:user]
      @item = params[:item]
      mail(to: @user.email, subject: 'Subscription for Unavailable Item')
    end
end
