require_relative '../coursescheduler.rb'

describe CourseScheduler do

  before(:all) do
    @cs = CourseScheduler.new
    @test_day_times = {
      "C1" => {:start => 1000, :end => 1100},
      "C2" => {:start => 1100, :end => 1200},
      "C3" => {:start => 1400, :end => 1600},
      "C4" => {:start => 1600, :end => 2000}
    }
  end

  describe '#does_course_fit' do
    before(:all) do
      @test_course_time_valid = {
        :start => 1200, :end => 1300
      }
      @test_course_time_valid_2 = {
        :start => 100, :end => 1000
      }
      @test_course_time_valid_3 = {
        :start => 2000, :end => 20000
      }
      @test_course_time_valid_4 = {
        :start => 1200, :end => 1400
      }

      @test_course_time_invalid = {
        :start => 1700, :end => 1800
      }
      @test_course_time_invalid_2 = {
        :start => 100, :end => 1001
      }
      @test_course_time_invalid_3 = {
        :start => 200, :end => 2000
      }
      @test_course_time_invalid_4 = {
        :start => 1099, :end => 1101
      }
    end

    it 'returns true on valid time slot' do
      res1 = @cs.does_course_fit(@test_course_time_valid, @test_day_times)
      expect(res1).to be_true

      res2 = @cs.does_course_fit(@test_course_time_valid_2, @test_day_times)
      expect(res2).to be_true

      res3 = @cs.does_course_fit(@test_course_time_valid_3, @test_day_times)
      expect(res3).to be_true

      res4 = @cs.does_course_fit(@test_course_time_valid_4, @test_day_times)
      expect(res4).to be_true
    end

    it 'returns false on invalid time slot' do
      res1 = @cs.does_course_fit(@test_course_time_invalid, @test_day_times)
      expect(res1).to be_false

      res2 = @cs.does_course_fit(@test_course_time_invalid_2, @test_day_times)
      expect(res2).to be_false

      res3 = @cs.does_course_fit(@test_course_time_invalid_3, @test_day_times)
      expect(res3).to be_false

      res4 = @cs.does_course_fit(@test_course_time_invalid_4, @test_day_times)
      expect(res4).to be_false
    end
  end
end



