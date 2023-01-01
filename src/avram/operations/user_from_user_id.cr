module Lucille::UserFromUserId
  macro included
    {% unless @type.methods.find(&.name.== :user.id) %}
      getter user : User? do
        user_id.value.try { |value| UserQuery.new.id(value).first? }
      end
    {% end %}
  end
end
