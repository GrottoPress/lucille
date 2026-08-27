require "../spec_helper"

describe FakeNestedParams do
  it "creates new empty params" do
    # Ensures no compile error:
    #   ```
    #   Error: can't infer block return type
    #   ```

    FakeNestedParams.new.get?("none").should be_nil
  end

  it "encodes time into value acceptable by the time adapter" do
    time = Time.local(Time::Location.load "Europe/Berlin")
    params = nested_params(user: {created_at: time})
    created_at = Time.adapter.parse!(params.nested(:user)["created_at"])

    created_at.should eq(time.at_beginning_of_second)
  end
end
