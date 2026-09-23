require "../spec_helper"

describe Lucille::QueryFilter do
  it "filters query" do
    user = UserFactory.create &.email("kofi@ghana.com")

    params = fake_form(search: "kofi")
    UserQueryFilter.new.run(params).first?.try(&.id).should(eq user.id)

    params = fake_form(search: "ama")
    UserQueryFilter.new.run(params).none?.should be_true
  end
end
