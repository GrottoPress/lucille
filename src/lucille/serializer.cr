# This duplicates `Lucky::Serializer`, so you can create
# serializers with `struct`s instead of `class`es
module Lucille::Serializer
  macro included
    def to_json(io)
      render.to_json(io)
    end
  end
end
