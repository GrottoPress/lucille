# There's `enum`, but that saves the enum value as `Int32` in
# the database. The problem is, enum member values are
# order-dependent -- the values change when the member ordering
# changes.
#
# Besides, you couldn't make sense of the numbers if you peeked
# into the database
#
# `__enum` saves enum members as `String` instead.
macro __enum(enum_name, &block)
  enum Raw{{ enum_name }}
    {{ block.body }}
  end

  struct {{ enum_name }}
    def self.adapter
      Lucky
    end

    def initialize(@raw : Raw{{ enum_name }})
    end

    def initialize(value : String)
      @raw = Raw{{ enum_name }}.parse(value)
    end

    def initialize(value : Symbol)
      @raw = initialize(value.to_s)
    end

    delegate :to_s, to: @raw
    forward_missing_to @raw

    def self.raw
      Raw{{ enum_name }}
    end

    module Lucky
      alias ColumnType = String

      include Avram::Type

      def self.criteria(query : T, column) forall T
        Criteria(T, {{ enum_name }}).new(query, column)
      end

      def parse(value : {{ enum_name }})
        SuccessfulCast({{ enum_name }}).new(value)
      end

      def parse(value : String)
        SuccessfulCast({{ enum_name }}).new {{ enum_name }}.new(value)
      rescue
        FailedCast.new
      end

      def parse(value : Symbol)
        parse value.to_s
      end

      def parse(values : Array)
        casts = values.map { |value| parse(value) }
        return FailedCast.new unless casts.all?(SuccessfulCast)

        SuccessfulCast(Array({{ enum_name }})).new(
          casts.map &.as(SuccessfulCast).value
        )
      end

      def to_db(value : {{ enum_name }})
        value.to_s
      end

      def to_db(values : Array({{ enum_name }}))
        PQ::Param.encode_array(values)
      end

      class Criteria(T, V) < String::Lucky::Criteria(T, V)
      end
    end
  end
end
