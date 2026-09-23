# Query filters are responsible for filtering queries based on
# request parameters. This is especially useful in API index actions,
# where clients may want to filter results based on a search query,
# for instance.
module Lucille::QueryFilter
  abstract def run(params : Avram::Paramable) : Avram::Queryable

  macro included
    def self.run(query, params)
      new(query).run(params)
    end

    def self.run(params)
      new.run(params)
    end
  end
end
