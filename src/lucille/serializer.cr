# This duplicates `Lucky::Serializer`, so you can create
# serializers with `struct`s instead of `class`es
module Lucille::Serializer
  macro included
    def to_json(io)
      render.to_json(io)
    end

    def self.for_collection(collection : Enumerable, *args, **named_args)
      collection.map { |object| new(object, *args, **named_args) }
    end
  end
end
