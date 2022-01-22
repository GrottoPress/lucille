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
