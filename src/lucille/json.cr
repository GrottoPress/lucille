require "hapi/resource"

module Lucille::JSON
  macro included
    include Hapi::Resource
  end
end
