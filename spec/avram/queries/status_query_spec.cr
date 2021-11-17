require "../../spec_helper"

describe Lucille::StatusQuery do
  it "retrieves active user" do
    user = UserFactory.create

    UserQuery.new.is_active.first?.should be_a(User)
    UserQuery.new.is_inactive.first?.should be_nil
    UserQuery.new.is_unactive.first?.should be_nil
  end

  it "retrieves active user" do
    user = UserFactory.create &.inactive_at(2.days.from_now.to_utc)

    UserQuery.new.is_active.first?.should be_a(User)
    UserQuery.new.is_inactive.first?.should be_nil
    UserQuery.new.is_unactive.first?.should be_nil
  end

  it "retrieves inactive user" do
    user = UserFactory.create &.inactive_at(Time.utc)

    UserQuery.new.is_active.first?.should be_nil
    UserQuery.new.is_inactive.first?.should be_a(User)
    UserQuery.new.is_unactive.first?.should be_nil
  end

  it "retrieves unactive user" do
    user = UserFactory.create &.active_at(2.days.from_now.to_utc)

    UserQuery.new.is_active.first?.should be_nil
    UserQuery.new.is_inactive.first?.should be_nil
    UserQuery.new.is_unactive.first?.should be_a(User)
  end
end
