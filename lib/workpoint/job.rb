module Workpoint
  class Job
    attr_accessor :due_on, :latitude, :longitude, :user

    def initialize(options = {})
      @due_on = options[:due_on]
      @latitude = options[:latitude]
      @longitude = options[:longitude]
      @user = options[:user]
    end

    def schedule!
      raise MalformedJobError.new("Job requires due date") unless @due_on
      raise MalformedJobError.new("Job requires latitude") unless @latitude
      raise MalformedJobError.new("Job requires longitude") unless @longitude
      raise MalformedJobError.new("Job requires username") unless @user

      Api.post "/jobs", {DueOn: @due_on, Latitude: @latitude, Longitude: @longitude, User: @user}
    end
  end
end
