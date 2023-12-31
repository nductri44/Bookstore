class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail(to: user.email, subject: 'Account activation')
  end

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: 'Password reset')
  end

  def order_complete(user, order, items)
    @user = user
    @order = order
    @items = items
    mail(to: user.email, subject: 'Order complete')
  end
end
