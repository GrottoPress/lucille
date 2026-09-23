struct UserQueryFilter
  include Lucille::QueryFilter

  def initialize(@query = UserQuery.new)
  end

  def run(params : Avram::Paramable) : UserQuery
    query = @query
    query = filter_search(query, params)
    query = filter_level(query, params)
    query = filter_order_by(query, params)
    query = filter_ids(query, params)
    query
  end

  private def filter_ids(query, params)
    params.get_all?(:ids).try do |ids|
      query = query.id.in(ids) unless ids.empty?
    end

    query
  end

  private def filter_level(query, params)
    params.get?(:level).try do |level|
      query = query.level(level) unless level.empty?
    end

    query
  end

  private def filter_order_by(query, params)
    params.nested?(:order_by).each do |column, order|
      clean_column = PG::EscapeHelper.escape_identifier(column)
      query = query.order_by(clean_column, order, :nulls_first)
    end

    query
  end

  private def filter_search(query, params)
    params.get?(:search).try do |search|
      unless search.empty?
        query = query.email.search(search)
      end
    end

    query
  end
end
