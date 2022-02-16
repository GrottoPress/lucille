require "../../spec_helper"

describe Lucille::StatusQuery do
  it "retrieves active user" do
    UserFactory.create

    UserQuery.new.is_active.first?.should be_a(User)
    UserQuery.new.is_inactive.first?.should be_nil
    UserQuery.new.is_pending.first?.should be_nil
    UserQuery.new.is_unactive.first?.should be_nil

    inactive_at = 2.days.from_now.to_utc.at_beginning_of_second
    UserQuery.new.update(inactive_at: inactive_at)

    UserQuery.new.is_active.first?.should be_a(User)
    UserQuery.new.is_inactive.first?.should be_nil
    UserQuery.new.is_pending.first?.should be_nil
    UserQuery.new.is_unactive.first?.should be_nil

    UserQuery.new.is_active(inactive_at).first?.should be_nil
    UserQuery.new.is_inactive(inactive_at).first?.should be_a(User)
    UserQuery.new.is_pending(inactive_at).first?.should be_nil
    UserQuery.new.is_unactive(inactive_at).first?.should be_nil
  end

  it "retrieves future active user" do
    active_at = 2.days.from_now.to_utc.at_beginning_of_second
    UserFactory.create &.active_at(active_at)

    UserQuery.new.is_active.first?.should be_nil
    UserQuery.new.is_inactive.first?.should be_nil
    UserQuery.new.is_pending.first?.should be_a(User)
    UserQuery.new.is_unactive.first?.should be_nil

    UserQuery.new.is_active(active_at).first?.should be_a(User)
    UserQuery.new.is_inactive(active_at).first?.should be_nil
    UserQuery.new.is_pending(active_at).first?.should be_nil
    UserQuery.new.is_unactive(active_at).first?.should be_nil

    inactive_at = 4.days.from_now.to_utc.at_beginning_of_second
    UserQuery.new.update(inactive_at: inactive_at)

    UserQuery.new.is_active.first?.should be_nil
    UserQuery.new.is_inactive.first?.should be_nil
    UserQuery.new.is_pending.first?.should be_a(User)
    UserQuery.new.is_unactive.first?.should be_nil

    UserQuery.new.is_active(active_at).first?.should be_a(User)
    UserQuery.new.is_inactive(active_at).first?.should be_nil
    UserQuery.new.is_pending(active_at).first?.should be_nil
    UserQuery.new.is_unactive(active_at).first?.should be_nil

    UserQuery.new.is_active(inactive_at).first?.should be_nil
    UserQuery.new.is_inactive(inactive_at).first?.should be_a(User)
    UserQuery.new.is_pending(inactive_at).first?.should be_nil
    UserQuery.new.is_unactive(inactive_at).first?.should be_nil
  end

  it "retrieves future inactive user" do
    active_at = 2.days.from_now.to_utc.at_beginning_of_second
    UserFactory.create &.active_at(active_at).inactive_at(active_at)

    UserQuery.new.is_active.first?.should be_nil
    UserQuery.new.is_inactive.first?.should be_nil
    UserQuery.new.is_pending.first?.should be_nil
    UserQuery.new.is_unactive.first?.should be_a(User)

    UserQuery.new.is_active(active_at).first?.should be_nil
    UserQuery.new.is_inactive(active_at).first?.should be_a(User)
    UserQuery.new.is_pending(active_at).first?.should be_nil
    UserQuery.new.is_unactive(active_at).first?.should be_nil
  end
end
