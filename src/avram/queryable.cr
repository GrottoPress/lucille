module Avram::Queryable(T)
  # Add ` FOR UPDATE` to the statement to fix concurrency bug
  # in `.validate_uniqueness_of` calls
  def any? : Bool
    cache_store.fetch(cache_key(:any?), as: Bool) do
      queryable = clone
      new_query = queryable.query.limit(1).select("1 AS one")
      results = database.query_one?("#{new_query.statement} FOR UPDATE", args: new_query.args, queryable: schema_class.name, as: (Int32 | Int64))
      !results.nil?
    end
  end
end
