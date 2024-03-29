module Lucille::SetUserIdFromUser
  macro included
    needs user : User?

    before_save do
      set_user_id
    end

    getter user : User? do
      user_id.value.try { |value| UserQuery.new.id(value).first? }
    end

    private def set_user_id
      user.try do |user|
        user_id.value = user.id
      end
    end
  end
end
