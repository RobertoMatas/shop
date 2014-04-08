class OrderMailer < ActionMailer::Base
	def order_completed_mail(user, order)
		@user = user
		@order = order
		mail(to: @user.email,
         subject: "Order #{@order.id} place correctly")
	end
end