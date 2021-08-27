def to_param_string(value)
  case value
  when Time
    value.to_utc.to_s("%Y-%m-%dT%H:%M:%S")
  else
    value.to_s
  end
end

def params(**named_args)
  Avram::Params.new named_args.to_h
    .transform_keys(&.to_s)
    .transform_values { |value| to_param_string(value) }
end

def nested_params(**named_args)
  FakeNestedParams.new(**named_args)
end

def assert_valid(attribute : Avram::Attribute)
  attribute.errors.should be_empty
end

def assert_valid(attribute : Avram::Attribute, text : String)
  attribute.errors.select(&.includes? text).should be_empty
end

def assert_valid(operation : Avram::Callbacks, key : Symbol)
  operation.errors[key]?.should be_nil
end

def assert_valid(operation : Avram::Callbacks, key : Symbol, text : String)
  operation.errors[key]?.try &.select(&.includes? text).should(be_empty)
end

def assert_invalid(attribute : Avram::Attribute)
  attribute.errors.should_not be_empty
end

def assert_invalid(attribute : Avram::Attribute, text : String)
  attribute.errors.select(&.includes? text).size.should eq(1)
end

def assert_invalid(operation : Avram::Callbacks, key : Symbol)
  operation.errors[key]?.should_not be_nil
end

def assert_invalid(operation : Avram::Callbacks, key : Symbol, text : String)
  operation.errors[key]?.try(&.select(&.includes? text).size).should eq(1)
end
