require "../spec_helper"

describe FakeParams do
  it "creates new empty params" do
    # Ensures no compile error:
    #   ```
    #   Error: can't infer block return type...
    #   ```

    FakeParams.new.get?("none").should be_nil
  end

  describe "#get?" do
    it "returns string for a given key" do
      params = params({name: "Alesia"})

      params.get?(:name).should eq("Alesia")
      params.get?(:missing).should be_nil
    end
  end

  describe "#get_all?" do
    it "returns array for a given key" do
      params = params({files: ["photo.jpg"]})

      params.get_all?(:files).should eq(["photo.jpg"])
      params.get_all?("missing").should be_nil
    end
  end
end
