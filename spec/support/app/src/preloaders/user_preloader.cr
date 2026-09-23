struct UserPreloader
  include Lucille::Preloader

  def run(query : Avram::Queryable, fields : Indexable(String)?) : UserQuery
    query
  end

  def run(record : Avram::Model, fields : Indexable(String)?) : User
    record
  end
end
