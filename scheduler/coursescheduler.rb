# recursively merge 2 hashes, works for hash of hashes
def recurse_merge(a, b)
  a.merge(b) do |_, x, y|
    (x.is_a?(Hash) && y.is_a?(Hash)) ? recurse_merge(x,y) : [*x,*y]
  end
end

class CourseScheduler

  #calculate a timetables "rating", critera is space between classes
  def get_schedule_rating(schedule)
    rating = 0
    schedule.each do |day, day_data|
      new_day = true #we haven't iterated over this day's courses yet
      last_time = 0 #the last course's end time
      day_data.each do |course_id, course_data|
        if new_day then
          new_day = false
          last_time = course_data[:end]
        else
          rating += course_data[:start] - last_time
        end
      end
    end
    return rating
  end

  def does_course_fit(course_times, day_times)
    #puts "TESTING: #{course_times}\nINTO: #{day_times}"
    day_times.each do |times|
      puts "TIMES #{times}"
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
    data.shuffle! #randomize the order of the courses
    schedule = {:MO => [], :TU => [], :WE => [], :TH => [], :FR => []}
    data.each do |course_info|
      course_fits = true
      course_scheduled = false

      course_info[:times].each do |id, time_option|
        unless course_scheduled
          tmp_schedule = {:MO => [], :TU => [], :WE => [], :TH => [], :FR => []}

          #loop through the course's time options and try to fit them into the current schedule
          time_option.each do |day, times|
            #if times then schedule[day].merge!({course_info[:id] => times}) end
            if does_course_fit(times, schedule[day]) then
              #tmp_schedule[day].merge!({course_info[:id] => times})
              tmp_schedule[day] << {:id => course_info[:id], :start => times[:start], :end => times[:end]}
              course_fits = true
            else
              course_fits = false
              break #if one of the course times doesn't fit, then this course time option cannot be sched so break out of the loop over this course time options
            end
          end

          #if the course then add it to the main schedule, set course_scheduled to true
          if course_fits then
            #puts "schedu: #{schedule}"
            if(defined? schedule && defined? tmp_schedule) then
              schedule.each do |day, day_data|
                #schedule[day] = recurse_merge(schedule[day], tmp_schedule[day])
                schedule[day] << tmp_schedule[day]
              end
              puts schedule
              course_scheduled = true
            end
          end
        end
      end

      unless course_scheduled
        return false #"schedule not possible - course: #{course_info[:id]} current sched: #{schedule}"
      end
    end
    return schedule
  end
end

#TODO: change this datastructure to array => hash => array => hash
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

#puts CourseScheduler.new.random_schedule(dataset)
cs = CourseScheduler.new

(1..10).each do |i|
  schedule = CourseScheduler.new.random_schedule(dataset)
  if schedule then
    rating = cs.get_schedule_rating(schedule)
    puts "SCHEDULE #{schedule} \n RATING: #{rating}"
  end
end
