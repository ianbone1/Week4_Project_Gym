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

end
