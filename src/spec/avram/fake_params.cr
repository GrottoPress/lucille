struct FakeParams
  include Avram::Paramable

  def initialize(params)
    @hash = Hash(String, Union(
      String,
      Array(String),
      Hash(String, Union(
        String,
        Array(String),
        Avram::Uploadable,
        Array(Avram::Uploadable)
      )),
      Array(Hash(String, String)),
      Avram::Uploadable,
      Array(Avram::Uploadable)
    )).new

    params.to_h.each do |key, value|
      next if value.nil?
      @hash[key.to_s] = build_params(value)
    end
  end

  def self.new(**params)
    new(params)
  end

  def get(key)
    get?(key).not_nil!
  end

  def get?(key : String | Symbol) : String?
    @hash[key.to_s]?.try do |string|
      string if string.is_a?(String)
    end
  end

  def get_all(key)
    get_all?(key).not_nil!
  end

  def get_all?(key : String | Symbol)
    @hash[key.to_s]?.try do |array|
      array if array.is_a?(Array(String))
    end
  end

  def nested(key) : Hash(String, String)
    nested?(key)
  end

  def nested?(key : String | Symbol) : Hash(String, String)
    Hash(String, String).new.tap do |params|
      @hash[key.to_s]?.try do |hash|
        next unless hash.is_a?(Hash)
        hash.each { |k, v| params[k] = v if v.is_a?(String) }
      end
    end
  end

  def nested_arrays(key) : Hash(String, Array(String))
    nested_arrays?(key)
  end

  def nested_arrays?(key : String | Symbol) : Hash(String, Array(String))
    Hash(String, Array(String)).new.tap do |params|
      @hash[key.to_s]?.try do |hash|
        next unless hash.is_a?(Hash)
        hash.each { |k, v| params[k] = v if v.is_a?(Array(String)) }
      end
    end
  end

  def many_nested(key) : Array(Hash(String, String))
    many_nested?(key)
  end

  def many_nested?(key : String | Symbol) : Array(Hash(String, String))
    @hash[key.to_s]?.try do |array|
      array if array.is_a?(Array(Hash(String, String)))
    end || Array(Hash(String, String)).new
  end

  def get_file(key)
    get_file?(key).not_nil!
  end

  def get_file?(key : String | Symbol) : Avram::Uploadable?
    @hash[key.to_s]?.try do |file|
      file if file.is_a?(Avram::Uploadable)
    end
  end

  def get_all_files(key)
    get_all_files?(key).not_nil!
  end

  def get_all_files?(key : String | Symbol)
    @hash[key.to_s]?.try do |array|
      array if array.is_a?(Array(Avram::Uploadable))
    end
  end

  def nested_file(key) : Hash(String, Avram::Uploadable)
    nested_file?(key)
  end

  def nested_file?(key : String | Symbol) : Hash(String, Avram::Uploadable)
    Hash(String, Avram::Uploadable).new.tap do |files|
      @hash[key.to_s]?.try do |hash|
        next unless hash.is_a?(Hash)
        hash.each { |k, v| files[k] = v if v.is_a?(Avram::Uploadable) }
      end
    end
  end

  def nested_array_files(key) : Hash(String, Array(Avram::Uploadable))
    nested_array_files?(key)
  end

  def nested_array_files?(key : String | Symbol)
    Hash(String, Array(Avram::Uploadable)).new.tap do |files|
      @hash[key.to_s]?.try do |hash|
        next unless hash.is_a?(Hash)
        hash.each { |k, v| files[k] = v if v.is_a?(Array(Avram::Uploadable)) }
      end
    end
  end

  private def build_params(params : Hash | NamedTuple)
    Hash(String, Union(
      String,
      Array(String),
      Avram::Uploadable,
      Array(Avram::Uploadable)
    )).new.tap do |hash|
      params.to_h.each do |key, value|
        hash[key.to_s] = build_nested_value(value)
      end
    end
  end

  private def build_params(params : Indexable(Hash) | Indexable(NamedTuple))
    params.compact_map do |param|
      hash = Hash(String, String).new
      param.to_h.each { |key, value| hash[key.to_s] = to_param(value) }
      hash unless hash.empty?
    end
  end

  private def build_params(params : Indexable(Avram::Uploadable))
    Array(Avram::Uploadable).new.tap do |array|
      params.each { |param| array << param }
    end
  end

  private def build_params(params : Indexable)
    params.map { |param| to_param(param) }
  end

  private def build_params(params : Avram::Uploadable)
    params
  end

  private def build_params(params)
    to_param(params)
  end

  private def build_nested_value(value : Avram::Uploadable)
    value
  end

  private def build_nested_value(value : Indexable(Avram::Uploadable))
    Array(Avram::Uploadable).new.tap do |array|
      value.each { |param| array << param }
    end
  end

  private def build_nested_value(value : Indexable)
    value.map { |item| to_param(item) }
  end

  private def build_nested_value(value)
    to_param(value)
  end
end
