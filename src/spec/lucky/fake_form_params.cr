struct FakeFormParams
  include Avram::Paramable

  @form : Lucky::Params

  def initialize(params)
    uri_params = URI::Params.build do |builder|
      params.each { |name, value| add_param(builder, name.to_s, value) }
    end

    @form = build_form(uri_params)
  end

  def self.new(**params)
    new(params)
  end

  forward_missing_to @form

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

  private def build_form(uri_params)
    headers = HTTP::Headers{
      "Content-Type" => "application/x-www-form-urlencoded"
    }

    request = HTTP::Request.new("POST", "/", headers, uri_params)
    Lucky::Params.new(request)
  end

  private def add_param(builder, name, value : Nil)
  end

  private def add_param(builder, name, value : Hash | NamedTuple)
    value.each do |key, nested_value|
      add_param(builder, "#{name}:#{key}", nested_value)
    end
  end

  private def add_param(builder, name, value : Indexable)
    value.each_with_index do |item, i|
      case item
      when Hash, NamedTuple
        item.each { |k, v| add_param(builder, "#{name}[#{i}]:#{k}", v) }
      else
        add_param(builder, "#{name}[]", item)
      end
    end
  end

  private def add_param(builder, name, value)
    builder.add name, to_param(value)
  end
end
