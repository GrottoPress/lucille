module Lucille::JSON
  macro included
    include JSON::Serializable
    include JSON::Serializable::Unmapped

    forward_missing_to json_unmapped

    def merge(other : self) : self
      merge JSON.parse(other.to_json).as_h
    end

    def merge(**other) : self
      merge(other.to_h)
    end

    def merge(other : Hash) : self
      hash = JSON.parse(to_json).as_h.merge(other)
      self.class.from_json(hash.to_json)
    end
  end
end
