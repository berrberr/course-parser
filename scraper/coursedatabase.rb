#TODO: add selects, add auto fill in timestamps
module CourseDatabase
  @TimeFmtStr = "%Y-%m-%d %H:%M:%S"
  @client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :database => 'coursesite')

  def self.get_timestamp()
    return Time.now.strftime(@TimeFmtStr)
  end

  def self.update_query(params)
    query = "UPDATE #{params.table} SET "
    params.data.each do |data|
      insert_data = if data[:val].is_a? Integer then data[:val] else "'#{data[:val]}'" end
      query += "#{data[:column]}=#{insert_data},"
    end
    query.slice!((query.length - 1)..-1)
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