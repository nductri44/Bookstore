class AdminMailer < ApplicationMailer
  def account_activation(admin)
    @admin = admin
    mail(to: admin.email, subject: 'Account activation')
  end

  def password_reset(admin)
    @admin = admin
    mail(to: admin.email, subject: 'Password reset')
  end

  def order_notification(admin, order, items)
    @admin = admin
    @order = order
    @items = items
    mail(to: admin.email, subject: 'Order notification')
  end
end
