# Filter responses based on request parameters, before sending them, via
# serializers, to clients.
#
# This enables a GraphQL-like filtering of responses using a REST interface.
#
# Clients indicate which fields they are interested in by using the `fields`
# parameter. For example: a request with
# `?fields[]=bearer_login.*&fields[]=user.name` parameters would receive a
# response which includes all bearer login fields and the bearer login user's
# names
module Lucille::ResponseFilter
  abstract def run(fields : Indexable(String)?, current_user : User?) : Hash

  macro included
    def run(params : Avram::Paramable, current_user : User?)
      run(params.get_all?("fields"), current_user)
    end

    def self.run(record : Avram::Model, params, current_user = nil)
      new(record).run(params, current_user)
    end

    def self.run(params, current_user = nil)
      new.run(params, current_user)
    end
  end
end
