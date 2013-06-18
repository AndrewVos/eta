require 'minitest/autorun'
require 'minitest/mock'
require 'timecop'
require 'eta/estimator'

describe Eta::Estimator do
  it 'should be able to stub #current_time' do
    estimator = Eta::Estimator.new { 0 }
    Timecop.freeze(Time.at(0))
    estimator.current_time.must_equal 0
  end

  it 'can calculate #elapsed_time' do
    Timecop.freeze(Time.at(0))
    estimator = Eta::Estimator.new
    estimator.start!
    Timecop.freeze(Time.at(100))
    estimator.elapsed_time.must_equal 100
  end

  it 'can calculate #expected_duration' do
    Timecop.freeze(Time.at(0))
    estimator = Eta::Estimator.new
    estimator.start!

    Timecop.freeze(Time.at(1000))

    estimator.percent_done = 0.25
    estimator.expected_duration.must_equal 4000
    estimator.percent_done = 0.5
    estimator.expected_duration.must_equal 2000
    estimator.percent_done = 0.8
    estimator.expected_duration.must_equal 1250

    Timecop.freeze(Time.at(500))
    estimator.expected_duration.must_equal 625
  end

  it 'can calculate #time_left' do
    Timecop.freeze(Time.at(0))
    estimator = Eta::Estimator.new
    estimator.start!

    Timecop.freeze(Time.at(1000))

    estimator.percent_done = 0.25
    estimator.time_left.must_equal 3000
    estimator.percent_done = 0.5
    estimator.time_left.must_equal 1000

    Timecop.freeze(Time.at(3000))
    estimator.percent_done = 0.75
    estimator.time_left.must_equal 1000
  end

  it 'can calculate #eta' do
    Timecop.freeze(Time.at(0))
    estimator = Eta::Estimator.new
    estimator.start!

    Timecop.freeze(Time.at(500))

    estimator.percent_done = 0.25
    estimator.eta.must_equal Time.at(2000)
    estimator.percent_done = 0.5
    estimator.eta.must_equal Time.at(1000)

    Timecop.freeze(Time.at(3000))
    estimator.percent_done = 0.75
    estimator.eta.must_equal Time.at(4000)
  end
end
