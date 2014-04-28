require "#{File.dirname(__FILE__)}/test_helper"

class JobTest < MiniTest::Unit::TestCase
  def test_job_requires_attributes
    assert_raises Workpoint::MalformedJobError do
      Workpoint::Job.new.schedule!
    end
  end

  def test_job_attempts_scheduling
    RestClient.expects(:post)
    Workpoint::Job.new(valid_attributes).schedule!
  end

  private

  def valid_attributes
    {due_on: "2013-01-01", latitude: 1, longitude: 2, user: "waldo"}
  end
end
