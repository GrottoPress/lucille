class String::Lucky::Criteria(T, V) < Avram::Criteria(T, V)
  def search(for keywords)
    split = keywords.split.join('%')
    pattern = "%#{split}%"
    leading = PG::EscapeHelper.escape_literal("#{split}%")

    ilike(pattern).order_by("#{column} ILIKE #{leading}", :desc)
      .order_by("length(#{column})", :asc)
  end
end
