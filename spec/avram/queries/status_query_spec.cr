require "../../spec_helper"

describe Lucille::StatusQuery do
  it "retrieves active user" do
    UserFactory.create

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive.any?.should be_false

    inactive_at = 2.days.from_now.to_utc.at_beginning_of_second
    UserQuery.new.update(inactive_at: inactive_at)

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive.any?.should be_false

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive(inactive_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive(inactive_at).any?.should be_false
  end

  it "retrieves future active user" do
    active_at = 2.days.from_now.to_utc.at_beginning_of_second
    UserFactory.create &.active_at(active_at)

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive.any?.should be_false

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active(active_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive(active_at).any?.should be_false

    inactive_at = 4.days.from_now.to_utc.at_beginning_of_second
    UserQuery.new.update(inactive_at: inactive_at)

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive.any?.should be_false

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active(active_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive(active_at).any?.should be_false

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive(inactive_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive(inactive_at).any?.should be_false
  end

  it "retrieves future inactive user" do
    active_at = 2.days.from_now.to_utc.at_beginning_of_second
    UserFactory.create &.active_at(active_at).inactive_at(active_at)

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive.any?.should be_true

    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_active(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_inactive(active_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_pending(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    UserQuery.new.is_unactive(active_at).any?.should be_false
  end
end
