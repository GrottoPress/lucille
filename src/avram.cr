require "pawn"
require "./avram/**"

module Avram
  abstract class Factory
    # Mainly so we can pass symbols as args for enums, but you
    # can also pass any type the column's type adapter supports.
    macro setup_attribute_shortcuts(operation)
      {% for attribute in operation.resolve.constant(:COLUMN_ATTRIBUTES) %}
        def {{ attribute[:name] }}(value)
          operation.{{ attribute[:name] }}.value =
            {{ attribute[:type] }}.adapter.parse!(value)

          self
        end
      {% end %}
    end
  end
end
