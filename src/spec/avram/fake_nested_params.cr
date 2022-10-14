struct FakeNestedParams
  include Avram::Paramable

  @hash : Hash(String, Hash(String, Array(String) | String)) | \
    Hash(String, Hash(String, Array(String))) | \
    Hash(String, Hash(String, String))

  def initialize(@hash)
  end

  def self.new(**params)
    hash = params.to_h.transform_keys(&.to_s)
      .transform_values &.to_h.transform_keys(&.to_s)
      .transform_values do |value|
        value.is_a?(Array) ?
          value.map { |_value| to_param(_value) } :
          to_param(value)
      end

    new(hash)
  end

  def nested(key) : Hash(String, String)
    nested?(key)
  end

  def nested?(key : String | Symbol) : Hash(String, String)
    Hash(String, String).new.tap do |params|
      @hash[key.to_s]?.try &.each do |_key, _value|
        params[_key] = _value if _value.is_a?(String)
      end
    end
  end

  def nested_arrays(key) : Hash(String, Array(String))
    nested_arrays?(key)
  end

  def nested_arrays?(key : String | Symbol) : Hash(String, Array(String))
    Hash(String, Array(String)).new.tap do |params|
      @hash[key.to_s]?.try &.each do |_key, _value|
        params[_key] = _value if _value.is_a?(Array)
      end
    end
  end

  def nested_file(key) : Hash(String, String)
    nested_file?(key)
  end

  def nested_file?(key : String) : Hash(String, String)
    nested?(key)
  end

  def many_nested(key) : Array(Hash(String, String))
    many_nested?(key)
  end

  def many_nested?(key : String) : Array(Hash(String, String))
    Hash(String, String).new
  end

  def get(key)
    get?(key)
  end

  def get?(key : String)
    nil
  end

  def get_all(key)
    get_all?(key)
  end

  def get_all?(key : String)
    nil
  end
end
