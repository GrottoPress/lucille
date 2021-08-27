require "../spec_helper"

private module Mail
  extend MailHelpers
end

describe MailHelpers do
  describe "#mail" do
    it "delivers mail now" do
      user = UserFactory.create
      Mail.mail(WelcomeEmail, user)
      Carbon.should have_delivered_emails
    end
  end

  describe "#mail_later" do
    it "delivers mail later" do
      user = UserFactory.create
      Mail.mail_later(WelcomeEmail, user)
      Carbon.should have_delivered_emails
    end
  end
end
