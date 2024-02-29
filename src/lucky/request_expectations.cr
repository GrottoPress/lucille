module Lucky
  module RequestExpectations
    def send_json(status, expected : NamedTuple)
      SendJsonExpectation.new(status, expected.to_json)
    end
  end
end
