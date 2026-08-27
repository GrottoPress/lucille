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

  describe "#nested" do
    it "returns string values for the given key" do
      params = nested_params(user: {name: "Alesia", age: "35"})

      params.nested(:user).should eq({"name" => "Alesia", "age" => "35"})
    end

    it "returns an empty hash for a missing key" do
      params = nested_params(user: {name: "Alesia"})

      params.nested(:missing).should be_empty
    end
  end

  describe "#nested_arrays" do
    it "returns array values for the given key" do
      params = nested_params(user: {name: "Alesia", tags: ["a", "b"]})

      params.nested_arrays(:user).should eq({"tags" => ["a", "b"]})
    end

    it "returns an empty hash for a missing key" do
      params = nested_params(user: {name: "Alesia"})

      params.nested_arrays(:missing).should be_empty
    end
  end

  describe "#nested_file" do
    it "returns string values for the given key" do
      params = nested_params(user: {name: "Alesia"})

      params.nested_file("user").should eq({"name" => "Alesia"})
    end
  end

  describe "#many_nested" do
    it "returns an array of hashes for the given key" do
      params = nested_params(files: [{name: "photo.jpg", size: 24000}])

      params.many_nested("files")
        .should(eq [{"name" => "photo.jpg", "size" => "24000"}])
    end

    it "returns an empty array for a missing key" do
      params = nested_params(users: [{name: "Alesia"}])

      params.many_nested("missing").should be_empty
    end

    it "returns an empty array when the value is a hash" do
      params = nested_params(user: {name: "Alesia"})

      params.many_nested("user").should be_empty
    end
  end

  describe "#get" do
    it "returns nil" do
      params = nested_params(user: {name: "Alesia"})

      params.get("user").should be_nil
    end
  end

  describe "#get?" do
    it "returns nil" do
      params = nested_params(user: {name: "Alesia"})

      params.get?("user").should be_nil
    end
  end

  describe "#get_all" do
    it "returns nil" do
      params = nested_params(user: {name: "Alesia"})

      params.get_all("user").should be_nil
    end
  end

  describe "#get_all?" do
    it "returns nil" do
      params = nested_params(user: {name: "Alesia"})

      params.get_all?("user").should be_nil
    end
  end
end
