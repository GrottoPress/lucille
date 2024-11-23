class String::Lucky::Criteria(T, V) < Avram::Criteria(T, V)
  def search(for keywords)
    split = keywords[0, 255].split.join('%')
    pattern = "%#{split}%"

    ilike(pattern).order_by("LENGTH(#{column})", :ASC)
  end
end
