struct FakeMultipartParams
  include Avram::Paramable

  @form : Lucky::Params

  def initialize(params)
    io = IO::Memory.new
    content_type = ""

    HTTP::FormData.build(io) do |builder|
      content_type = builder.content_type
      params.each { |name, value| add_field(builder, name.to_s, value) }
    end

    @form = build_form(io, content_type)
  end

  def self.new(**params)
    new(params)
  end

  forward_missing_to @form

  private def build_form(io, content_type)
    headers = HTTP::Headers{"Content-Type" => content_type}
    request = HTTP::Request.new("POST", "/", headers, io.rewind)

    Lucky::Params.new(request)
  end

  def get(key)
    @form.get(key)
  end

  def get?(key : String | Symbol) : String?
    @form.get?(key)
  end

  def get_all(key)
    @form.get_all(key)
  end

  def get_all?(key : String | Symbol)
    @form.get_all?(key)
  end

  def nested(key) : Hash(String, String)
    @form.nested(key)
  end

  def nested?(key : String | Symbol) : Hash(String, String)
    @form.nested?(key)
  end

  def nested_arrays(key) : Hash(String, Array(String))
    @form.nested_arrays(key)
  end

  def nested_arrays?(key : String | Symbol) : Hash(String, Array(String))
    @form.nested_arrays?(key)
  end

  def many_nested(key) : Array(Hash(String, String))
    @form.many_nested(key)
  end

  def many_nested?(key : String | Symbol) : Array(Hash(String, String))
    @form.many_nested?(key)
  end

  private def add_field(builder, name, value : Nil)
  end

  private def add_field(builder, name, value : Hash | NamedTuple)
    value.each do |key, nested_value|
      add_field(builder, "#{name}:#{key}", nested_value)
    end
  end

  private def add_field(builder, name, value : Array | Tuple)
    value.each_with_index do |item, i|
      case item
      when Hash, NamedTuple
        item.each { |k, v| add_field(builder, "#{name}[#{i}]:#{k}", v) }
      else
        add_field(builder, "#{name}[]", item)
      end
    end
  end

  private def add_field(builder, name, value : Lucky::UploadedFile)
    builder.file name,
      value.tempfile,
      HTTP::FormData::FileMetadata.new(filename: value.filename)
  end

  private def add_field(builder, name, value)
    builder.field name, to_param(value)
  end
end
