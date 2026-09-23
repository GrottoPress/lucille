# Preloaders preload associations based on request parameters. This is used
# with response filters to preload only associations that are actually requested
# by the client.
module Lucille::Preloader
  abstract def run(
    query : Avram::Queryable,
    fields : Indexable(String)?
  ) : Avram::Queryable

  abstract def run(
    record : Avram::Model,
    fields : Indexable(String)?
  ) : Avram::Model

  macro included
    def run(query, params : Avram::Paramable)
      run(query, params.get_all?("fields"))
    end

    def self.run(query, params)
      new.run(query, params)
    end
  end
end
