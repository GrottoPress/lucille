struct FakeMultipartParams
  getter body : IO
  getter content_type : String

  def initialize(params : NamedTuple)
    @content_type = ""
    io = IO::Memory.new

    HTTP::FormData.build(io) do |builder|
      @content_type = builder.content_type
      params.each { |name, value| add_field(builder, name.to_s, value) }
    end

    @body = io.rewind
  end

  def self.new(**params)
    new(params)
  end

  private def add_field(builder, name, value : Nil)
  end

  private def add_field(builder, name, value : Hash | NamedTuple)
    value.each do |key, nested_value|
      add_field(builder, "#{name}:#{key}", nested_value)
    end
  end

  private def add_field(builder, name, value : Array)
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
