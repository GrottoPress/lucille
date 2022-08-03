require "../../spec_helper"

describe Lucille::SuccessQuery do
  it "retrieves records with success status" do
    PasswordResetFactory.create &.success(true)

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive.any?.should be_false
  end

  it "retrieves records with failure status" do
    PasswordResetFactory.create &.success(false).inactive_at(Time.utc)

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive.any?.should be_false

    inactive_at = 2.days.from_now.to_utc.at_beginning_of_second
    PasswordResetQuery.new.update(inactive_at: inactive_at)

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive.any?.should be_false

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure(inactive_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive(inactive_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive(inactive_at).any?.should be_false
  end

  it "retrieves records with pending status" do
    active_at = 2.days.from_now.to_utc.at_beginning_of_second
    PasswordResetFactory.create &.active_at(active_at)

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive.any?.should be_false

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active(active_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive(active_at).any?.should be_false

    inactive_at = 4.days.from_now.to_utc.at_beginning_of_second
    PasswordResetQuery.new.update(inactive_at: inactive_at)

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending.any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive.any?.should be_false

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active(active_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive(active_at).any?.should be_false

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure(inactive_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive(inactive_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending(inactive_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive(inactive_at).any?.should be_false
  end

  it "retrieves records with unactive status" do
    active_at = 2.days.from_now.to_utc.at_beginning_of_second
    PasswordResetFactory.create &.active_at(active_at).inactive_at(active_at)

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending.any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive.any?.should be_true

    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_success(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_failure(active_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_active(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_inactive(active_at).any?.should be_true
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_pending(active_at).any?.should be_false
    # ameba:disable Performance/AnyInsteadOfEmpty
    PasswordResetQuery.new.is_unactive(active_at).any?.should be_false
  end
end
