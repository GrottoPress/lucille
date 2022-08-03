require "../../spec_helper"

describe SuccessStatus do
  it "returns success status" do
    password_reset = PasswordResetFactory.create &.success(true)
    password_reset.status.to_s.should eq("success")
    password_reset.status.inactive?.should be_true
  end

  it "returns failure status" do
    password_reset = PasswordResetFactory.create &.success(false)
      .inactive_at(Time.utc)

    password_reset.status.to_s.should eq("failure")
    password_reset.status.inactive?.should be_true
  end

  it "returns active status" do
    password_reset = PasswordResetFactory.create &.success(false)

    password_reset.status.to_s.should eq("active")
  end

  it "returns pending status" do
    password_reset = PasswordResetFactory.create &.success(false)
      .active_at(1.day.from_now)

    password_reset.status.to_s.should eq("pending")
  end

  it "returns unactive status" do
    time = 1.day.from_now

    password_reset = PasswordResetFactory.create &.active_at(time)
      .inactive_at(time)

    password_reset.status.to_s.should eq("unactive")
  end
end
