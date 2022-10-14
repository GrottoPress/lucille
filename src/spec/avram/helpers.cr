def to_param(value)
  case value
  when .responds_to?(:to_param)
    value.to_param
  when Time
    value.to_utc.to_rfc2822
  else
    value.to_s
  end
end

def params(**named_args)
  FakeParams.new(**named_args)
end

def nested_params(**named_args)
  FakeNestedParams.new(**named_args)
end
