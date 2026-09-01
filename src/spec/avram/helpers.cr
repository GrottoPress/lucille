require "../to_param"

include Lucille::ToParam

def fake_params(**params)
  fake_params(params)
end

def fake_params(params)
  FakeNestedParams.new(params)
end

@[Deprecated("Use fake_params instead")]
def nested_params(**params)
  FakeNestedParams.new(params)
end

@[Deprecated("Use fake_params instead (with a nesting key if nested)")]
def params(**params)
  FakeParams.new(params)
end
