require "../to_param"

include Lucille::ToParam

def fake_params(**params)
  fake_params(params)
end

def fake_params(params)
  FakeParams.new(params)
end
