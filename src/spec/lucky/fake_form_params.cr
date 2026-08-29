struct FakeFormParams
  getter body : IO

  def initialize(params : NamedTuple)
    io = IO::Memory.new
    uri_params = URI::Params.new

    params.each { |name, value| add_param(uri_params, name.to_s, value) }
    io << uri_params

    @body = io.rewind
  end

  def self.new(**params)
    new(params)
  end

  private def add_param(uri_params, name, value : Nil)
  end

  private def add_param(uri_params, name, value : Hash | NamedTuple)
    value.each do |key, nested_value|
      add_param(uri_params, "#{name}:#{key}", nested_value)
    end
  end

  private def add_param(uri_params, name, value : Array)
    value.each_with_index do |item, i|
      case item
      when Hash, NamedTuple
        item.each { |k, v| add_param(uri_params, "#{name}[#{i}]:#{k}", v) }
      else
        add_param(uri_params, "#{name}[]", item)
      end
    end
  end

  private def add_param(uri_params, name, value)
    uri_params.add name, to_param(value)
  end
end
