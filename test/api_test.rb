require 'uri'
require "#{File.dirname(__FILE__)}/test_helper"

class JobTest < MiniTest::Unit::TestCase
  def test_job_requires_attributes
    assert_raises Workpoint::MalformedJobError do
      Workpoint::Job.new.schedule!
    end
  end

  def test_job_successfully_schedules_job
    RestClient.expects(:post).once.with do |url, parameters, headers|
      assert URI.parse(url)
      assert_equal "asdf", headers["ApiKey"]
    end
    Workpoint::Api.api_key = "asdf"
    Workpoint::Job.new(valid_attributes).schedule!
  end

  def test_job_attempts_scheduling_without_api_key
    assert_raises Workpoint::NoApiKeyError do
      Workpoint::Job.new(valid_attributes).schedule!
    end
  end

  private

  def valid_attributes
    {due_on: "2013-01-01", latitude: 1, longitude: 2, user: "waldo"}
  end
end
