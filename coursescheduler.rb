# recursively merge 2 hashes, works for hash of hashes
def recurse_merge(a, b)
  a.merge(b) do |_, x, y|
    (x.is_a?(Hash) && y.is_a?(Hash)) ? recurse_merge(x,y) : [*x,*y]
  end
end

class CourseScheduler
  def does_course_fit(course_times, day_times)
    puts "TESTING: #{course_times}\nINTO: #{day_times}"
    conflicts = 0
    day_times.each do |id, times|
      if ((course_times[:start] >= times[:start]) and (course_times[:start] >= times[:end])) then
        next
      elsif ((course_times[:start] < times[:start]) and (course_times[:end] <= times[:start])) then
        next
      else
        puts "CONFLICT"
        return false
      end
    end
    puts "FITS"
    return true
  end

  def random_schedule(data)
    schedule = {:MO => {}, :TU => {}, :WE => {}, :TH => {}, :FR => {}}
    data.each do |course_info|
      course_fits = true
      course_scheduled = false

      course_info[:times].each do |id, time_option|
        unless course_scheduled
          tmp_schedule = {:MO => {}, :TU => {}, :WE => {}, :TH => {}, :FR => {}}
          time_option.each do |day, times|
            #if times then schedule[day].merge!({course_info[:id] => times}) end
            if does_course_fit(times, schedule[day]) then
              tmp_schedule[day].merge!({course_info[:id] => times})
            else
              course_fits = false
            end
          end
        end
        
        if course_fits then
          schedule = recurse_merge(schedule, tmp_schedule)
          puts schedule
          course_scheduled = true
        end
      end

      unless course_scheduled
        return "schedule not possible"
      end
    end
    return schedule
  end
end


dataset = [
  { :id => "1A1", :times => {
    1 => {
      :MO => { :start => 900, :end => 1000 },
      :TU => { :start => 1400, :end => 1600}
      },
    2 => {
      :TH => { :start => 1500, :end => 1800}
    }},
    :length => 180
  },
  { :id => "1B1", :times => {
    1 => {
      :WE => { :start => 1000, :end => 1100},
      :TH => { :start => 1000, :end => 1100},
      :FR => { :start => 1200, :end => 1300}
      },
    2 => {
      :MO => { :start => 1500, :end => 1600},
      :TU => { :start => 1500, :end => 1600},
      :FR => { :start => 1700, :end => 1800}
      },
    3 => {
      :WE => { :start => 900, :end => 1200}
    }},
    :length => 180
  },
  { :id => "1C1", :times => {
    1 => {
      :WE => { :start => 1200, :end => 1300},
      :TH => { :start => 1200, :end => 1300},
      :FR => { :start => 1200, :end => 1300}
      },
    2 => {
      :MO => { :start => 1600, :end => 1700},
      :TU => { :start => 1600, :end => 1700},
      :FR => { :start => 1800, :end => 1900}
      },
    3 => {
      :FR => { :start => 900, :end => 1200}
    }},
    :length => 180
  },
  {
    :id => "2A1", :times => {
      1 => {
        :MO => { :start => 900, :end => 1000},
        :TU => { :start => 1200, :end => 1400}
      }
    },
    :length => 180
  }
]

puts CourseScheduler.new.random_schedule(dataset)