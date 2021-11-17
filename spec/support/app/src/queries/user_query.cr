class UserQuery < User::BaseQuery
  include Lucille::StatusQuery
end
