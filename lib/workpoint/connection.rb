module Workpoint
  class Api
    class << self
      attr_accessor :api_key
    end
    BASE_URL = "https://alpha.touchin2.com"

    def self.post(path, data)
      raise NoApiKeyError.new("You must set Workpoint::Api.api_key") unless api_key

      RestClient.post BASE_URL + path, data, headers
    end

    def self.get
      raise NoApiKeyError.new("You must set Workpoint::Api.api_key") unless api_key
    end

    private

    def self.headers
      {"Content-Type" => "application/json", "ApiKey" => api_key}
    end
  end
end
