require "../spec_helper"

describe Lucille::HaveErrorExpectation do
  describe "#have_error" do
    context "in positive assertions" do
      it "passes if attribute is invalid" do
        attribute = Avram::Attribute(String).new(
          :email,
          param: nil,
          value: "user.name@domain.tLD",
          param_key: "user"
        )

        attribute.add_error("is required")

        attribute.should have_error
        attribute.should have_error("is required")
      end

      it "fails if attribute is valid" do
        attribute = Avram::Attribute(String).new(
          :email,
          param: nil,
          value: "user.name@domain.tLD",
          param_key: "user"
        )

        expect_raises Spec::AssertionFailed, "have an error" do
          attribute.should have_error
        end

        expect_raises Spec::AssertionFailed, "have the error " do
          attribute.should have_error("is required")
        end
      end

      it "fails if attribute is invalid but without the given error" do
        attribute = Avram::Attribute(String).new(
          :email,
          param: nil,
          value: "user.name@domain.tLD",
          param_key: "user"
        )

        attribute.add_error("is required")

        expect_raises Spec::AssertionFailed, "have the error " do
          attribute.should have_error("wrong message")
        end
      end
    end

    context "in negative assertions" do
      it "passes if attribute is valid" do
        attribute = Avram::Attribute(String).new(
          :email,
          param: nil,
          value: "user.name@domain.tLD",
          param_key: "user"
        )

        attribute.should_not have_error
        attribute.should_not have_error("is required")
      end

      it "fails if attribute is invalid" do
        attribute = Avram::Attribute(String).new(
          :email,
          param: nil,
          value: "user.name@domain.tLD",
          param_key: "user"
        )

        attribute.add_error("is required")

        expect_raises Spec::AssertionFailed, "not have an error" do
          attribute.should_not have_error
        end

        expect_raises Spec::AssertionFailed, "not have the error " do
          attribute.should_not have_error("is required")
        end
      end

      it "passes if attribute is invalid but without the given error" do
        attribute = Avram::Attribute(String).new(
          :email,
          param: nil,
          value: "user.name@domain.tLD",
          param_key: "user"
        )

        attribute.add_error("is required")

        attribute.should_not have_error("wrong message")
      end
    end
  end
end
