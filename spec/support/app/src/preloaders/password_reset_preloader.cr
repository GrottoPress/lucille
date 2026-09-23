struct PasswordResetPreloader
  include Lucille::Preloader

  def run(
    query : Avram::Queryable,
    fields : Indexable(String)?
  ) : PasswordResetQuery
    query = preload_user(query, fields)
    query
  end

  def run(
    record : Avram::Model,
    fields : Indexable(String)?
  ) : PasswordReset
    password_reset = preload_user(record, fields)
    password_reset
  end

  private def preload_user(query : PasswordResetQuery, fields)
    if QueryPattern.match?("user.*", fields)
      query = query.preload_user(preload_user_query fields)
    end

    query
  end

  private def preload_user(password_reset : PasswordReset, fields)
    if QueryPattern.match?("user.*", fields)
      password_reset = PasswordResetQuery.preload_user(
        password_reset,
        preload_user_query(fields),
        force: true
      )
    end

    password_reset
  end

  private def preload_user_query(fields)
    UserPreloader.run(UserQuery.new, fields)
  end
end
