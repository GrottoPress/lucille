# This checks if any field in a collection of fields matches a pattern. It is
# used in query loaders and response filters to match request parameters with a
# pattern to determine which items should appear in API responses.
#
# A pattern is always two parts; a resource and an attribute separated by a dot
# (.). Eg: `user.name`, `bearer_login.name`, `login.*`.
#
# Patterns that end with ".*" are wildcards.
struct QueryPattern
  def initialize(@pattern : String)
  end

  def match?(*fields : String)
    match?(fields)
  end

  def match?(fields : Indexable(String)?) : Bool?
    fields.try do |items|
      items.any? do |item|
        next item.starts_with?(@pattern[..-2]) if @pattern.ends_with?(".*")
        next @pattern.starts_with?(item[..-2]) if item.ends_with?(".*")

        item == @pattern
      end
    end
  end

  def self.match?(pattern, fields)
    new(pattern).match?(fields)
  end
end
