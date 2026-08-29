require "../to_param"

include Lucille::ToParam

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

  io = content.is_a?(IO) ? content : IO::Memory.new(content)
  part = HTTP::FormData::Part.new(headers, io)

  Lucky::UploadedFile.new(part)
end
