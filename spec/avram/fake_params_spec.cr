require "../spec_helper"

describe FakeParams do
  it "creates new empty params" do
    # Ensures no compile error:
    #   ```
    #   Error: can't infer block return type...
    #   ```

    FakeParams.new.get?("none").should be_nil
  end
end
