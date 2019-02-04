require_relative("./GymClass.rb")
require_relative("./Member.rb")
require_relative("./Schedule.rb")

class Booking

  # CREATE TABLE bookings(
  #   id SERIAL8 PRIMARY KEY,
  #   member_id INT8 REFERENCES members(id) ON DELETE CASCADE,
  #   schedule_id INT8 REFERENCES schedules(id) ON DELETE CASCADE
  # );
  attr_reader :id, :member_id, :schedule_id
  attr_writer :member_id, :schedule_id

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @member_id = params['member_id'].to_i
    @schedule_id = params['schedule_id'].to_i
  end

  def self.map_data(data_hash)
    result = data_hash.map { |data| self.new( data ) }
    return result
  end

  def save()
    sql = "INSERT INTO bookings (member_id, schedule_id)
      VALUES ($1, $2) RETURNING id;"
    values= [@member_id, @schedule_id]
    @id = SQLRunner.execute(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE bookings SET (member_id, schedule_id)
      = ($1, $2) WHERE id = $3;"
    values= [@member_id, @schedule_id, @id]
    SQLRunner.execute(sql, values)
  end

  def delete()
    sql = "DELETE FROM bookings WHERE id = $1;"
    values = [@id]
    SQLRunner.execute(sql, values)
  end

  def check_space
    sql = "SELECT count(b.*) bookings
      FROM bookings b
      WHERE schedule_id = $1;"
    values = [@schedule_id]
    booking_count = SQLRunner.execute(sql, values).first['bookings'].to_i
    binding.pry
    return booking_count
  end

  def self.delete_all
    sql = "DELETE FROM bookings;"
    SQLRunner.execute(sql)
  end

  def self.find_by_id(the_id)
    sql = "SELECT * FROM bookings
      WHERE id = $1;"
    values = [the_id]
    return self.map_data(SQLRunner.execute(sql, values)).first
  end


end
