struct FakeParams
  include Avram::Paramable

  def initialize(params)
    @hash = Hash(String, Union(
      Hash(String, Array(String) | String),
      Array(Hash(String, String)),
      Array(String),
      String
    )).new

    params.to_h.each do |key, value|
      case value
      when Nil
      when Hash, NamedTuple
        @hash[key.to_s] = build_nested(value)
      when Array(String), Tuple(String)
        @hash[key.to_s] = build_many(value)
      when Array, Tuple
        @hash[key.to_s] = build_many_nested(value)
      else
        @hash[key.to_s] = to_param(value)
      end
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

  private def build_nested(params)
    Hash(String, Array(String) | String).new.tap do |hash|
      params.to_h.each do |key, value|
        hash[key.to_s] = if value.is_a?(Array)
          value.map { |_value| to_param(_value) }
        else
          to_param(value)
        end
      end
    end
  end

  private def build_many_nested(params)
    Array(Hash(String, String)).new.tap do |array|
      params.each do |param|
        hash = Hash(String, String).new

        case param
        when Hash, NamedTuple
          param.to_h.each do |key, value|
            hash[key.to_s] = to_param(value)
          end
        end

        array << hash unless hash.empty?
      end
    end
  end

  private def build_many(params)
    Array(String).new.tap do |array|
      params.each do |param|
        array << param if param.is_a?(String)
      end
    end
  end
end
