require 'mysql2'
require 'ostruct'

#TODO: add selects, add auto fill in timestamps
# params format:
## table => [str] name of table
## data => [array of hashes] data to insert, pairs of :val, :column
## condition => [array of hashes] conditions of the query, inserted after WHERE, pairs of :val, :column
## timestamp => [array] names of columns to insert timestamps for query
module CourseDatabase
  @TimeFmtStr = "%Y-%m-%d %H:%M:%S"
  @client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :database => 'coursesite')

  # @return [timestamp] current time in MySQL timestamp format
  def self.get_timestamp()
    return Time.now.strftime(@TimeFmtStr)
  end

  def self.insert_timestamps(query, params)
    ts = get_timestamp()
    params.timestamp.each do |column|
      query += "#{column}='#{ts}',"
    end
    query.slice!((query.length - 1)..-1)
    return query
  end

  # Run an UPDATE query on the database
  def self.update_query(params)
    query = "UPDATE #{params.table} SET "
    params.data.each do |data|
      insert_data = if data[:val].is_a? Integer then data[:val] else "'#{data[:val]}'" end
      query += "#{data[:column]}=#{insert_data},"
    end
    query = if(params.timestamp) then 
      insert_timestamps(query, params)
    else
      query.slice((query.length - 1)..-1)
    end

    if(params.condition) then
      query += " WHERE "
      params.condition.each do |cond|
        insert_data = if cond[:val].is_a? Integer then cond[:val] else "'#{cond[:val]}'" end
        query += "#{cond[:column]}=#{insert_data} AND "
      end
      query.slice!((query.length - 5)..-1)
    end
    print "UPDATED: #{query}"
    @client.query(query)
  end

  # Run an INSERT query on the database
  def self.insert_query(params)
    cols, vals = "", ""
    params.data.each do |data|
      cols += "#{data[:column]},"
      vals += if data[:val].is_a? Integer then "#{data[:val]}," else "'#{data[:val]}'," end
    end
    cols.slice!((cols.length - 1)..-1)
    vals.slice!((vals.length - 1)..-1)
    query = "INSERT INTO #{params.table}(#{cols}) VALUES(#{vals})"
    @client.query(query)
  end
end

# TEST
test_update = OpenStruct.new('table' => 'courses', 
  'data' => [{:column => "course_code", :val => "1AA3"}],
  'timestamp' => ['updated_at', 'parsed_at'],
  'condition' => [{:column => "course_code", :val => "1AA3"}, {:column => "subject_code", :val => "ANTHROP"}])
CourseDatabase.update_query(test_update)