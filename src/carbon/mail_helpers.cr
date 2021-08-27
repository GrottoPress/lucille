module MailHelpers
  def mail(email : Carbon::Email.class, *args, **kwargs) : Nil
    email.new(*args, **kwargs).deliver
  end

  def mail_later(email : Carbon::Email.class, *args, **kwargs) : Nil
    email.new(*args, **kwargs).deliver_later
  end
end
