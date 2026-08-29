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

def fake_json(**params)
  fake_json(params)
end

def fake_json(params)
  headers = HTTP::Headers{"Content-Type" => "application/json"}
  request = HTTP::Request.new("POST", "/", headers, params.to_json)

  Lucky::Params.new(request)
end

def fake_form(**params)
  fake_form(params)
end

def fake_form(params)
  FakeFormParams.new(params)
end

def fake_multipart(**params)
  fake_multipart(params)
end

def fake_multipart(params)
  FakeMultipartParams.new(params)
end

def fake_file(content, filename : String? = nil) : Lucky::UploadedFile
  filename ||= Random.new.hex

  headers = HTTP::Headers{
    "Content-Disposition" => %(form-data; name="file"; filename="#{filename}")
  }

  part = HTTP::FormData::Part.new(headers, IO::Memory.new(content))
  Lucky::UploadedFile.new(part)
end
