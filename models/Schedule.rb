require_relative('../db/SQLRunner.rb')

class Schedule

  # CREATE TABLE schedules (
  #   id SERIAL8 PRIMARY KEY,
  #   gymclass_id INT8 REFERENCES gymclasses(id) ON DELETE CASCADE,
  #   start_date DATE NOT NULL DEFAULT CURRENT_DATE,
  #   start_time TIME NOT NULL DEFAULT CURRENT_TIME,
  #   duration TIME NOT NULL,
  #   max_attendees INT NOT NULL

  attr_reader :id, :gymclass_id, :start_date, :start_time, :duration, :max_attendees
  attr_writer :gymclass_id, :start_date, :start_time, :duration, :max_attendees

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @gymclass_id = params['gymclass_id'].to_i
    @start_date = params['start_date']
    @start_time = params['start_time']
    @duration = params['duration']
    @max_attendees = params['max_attendees'].to_i
  end

  def self.map_data(data_hash)
    result = data_hash.map { |data| self.new( data ) }
    return result
  end

  def save()
    sql = "INSERT INTO schedules ( gymclass_id, start_date,
      start_time, duration, max_attendees)
      VALUES ($1, $2, $3, $4, $5) RETURNING id;"
    values = [@gymclass_id, @start_date, @start_time, @duration, @max_attendees]
    @id = SQLRunner.execute(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE schedules SET (gymclass_id, start_date, start_time,
      duration, max_attendees) = ($1, $2, $3, $4, $5) WHERE id = $6;"
    values= [@gymclass_id, @start_date, @start_time, @duration, @max_attendees, @id]
    SQLRunner.execute(sql, values)
  end

  def delete()
    sql = "DELETE FROM schedules WHERE id = $1;"
    values = [@id]
    SQLRunner.execute(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM sschedules;"
    SQLRunner.execute(sql)
  end

  def self.find_by_id(the_id)
    sql = "SELECT * FROM schedules
      WHERE id = $1;"
    values = [the_id]
    return self.map_data(SQLRunner.execute(sql, values)).first
  end

  def self.all()
    sql = "SELECT schedules.* FROM schedules;"
    return self.map_data(SQLRunner.execute(sql))
  end



end
