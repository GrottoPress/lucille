require "../../spec_helper"

describe RecordStatus do
  it "returns active status" do
    user = UserFactory.create &.active_at(1.day.ago)
    status = RecordStatus.new(user)
    status.to_s.should eq("Active")
  end

  it "returns inactive status" do
    user = UserFactory.create &.active_at(2.days.ago).inactive_at(1.day.ago)
    status = RecordStatus.new(user)
    status.to_s.should eq("Inactive")
  end

  it "returns pending status" do
    user = UserFactory.create &.active_at(1.day.from_now)
    status = RecordStatus.new(user)
    status.to_s.should eq("Pending")
  end

  it "returns unactive status" do
    time = 1.day.from_now
    user = UserFactory.create &.active_at(time).inactive_at(time)
    status = RecordStatus.new(user)
    status.to_s.should eq("Unactive")
  end
end
