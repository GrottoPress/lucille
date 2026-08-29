struct FakeParams
  include Avram::Paramable

  def initialize(params)
    @hash = Hash(String, Union(
      String,
      Array(String),
      Hash(String, String | Array(String)),
      Array(Hash(String, String))
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
        hash.each { |k, v| params[k] = v if v.is_a?(Array) }
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
    get_file?(key)
  end

  def get_file?(key)
    get?(key)
  end

  def get_all_files(key)
    get_all_files?(key)
  end

  def get_all_files?(key)
    get_all?(key)
  end

  def nested_file(key) : Hash(String, String)
    nested_file?(key)
  end

  def nested_file?(key : String | Symbol) : Hash(String, String)
    nested?(key)
  end

  def nested_array_files(key)
    nested_array_files?(key)
  end

  def nested_array_files?(key)
    nested_array?(key)
  end

  private def build_params(params : Hash | NamedTuple)
    Hash(String, Array(String) | String).new.tap do |hash|
      params.to_h.each do |key, value|
        hash[key.to_s] = value.is_a?(Indexable) ?
          value.map { |_value| to_param(_value) } :
          to_param(value)
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

  private def build_params(params : Indexable)
    params.map { |param| to_param(param) }
  end

  private def build_params(params)
    to_param(params)
  end
end
