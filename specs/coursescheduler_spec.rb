require_relative '../coursescheduler.rb'

describe CourseScheduler do
  before do
    puts "GOTHERE"
    @cs = CourseScheduler.new
    @test_day_times = {
      "C1" => {:start => 1000, :end => 1100},
      "C2" => {:start => 1100, :end => 1200},
      "C3" => {:start => 1400, :end => 1600},
      "C4" => {:start => 1600, :end => 2000}
    }
  end

  describe '#does_course_fit' do
    puts "TDT: #{@test_day_times}"
    describe 'returns true on valid time slot' do
      test_course_time_valid = {
        :start => 1200, :end => 1300
      }
      test_course_time_valid_2 = {
        :start => 100, :end => 1000
      }
      test_course_time_valid_3 = {
        :start => 2000, :end => 20000
      }
      test_course_time_valid_4 = {
        :start => 1200, :end => 1400
      }
      res = CourseScheduler.new.does_course_fit(test_course_time_valid, @test_day_times)
      expect(res).to be_true
    end

    describe 'returns false on invalid time slot' do

    end
  end
end


test_course_time_invalid = {
  :start => 1700, :end => 1800
}
test_course_time_invalid2 = {
  :start => 100, :end => 1001
}
test_course_time_invalid3 = {
  :start => 200, :end => 2000
}
