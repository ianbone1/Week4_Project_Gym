require_relative('../db/SQLRunner.rb')
require_relative('./Schedule.rb')
require_relative('./Booking.rb')
require_relative('./Member.rb')

class GymClass

  attr_reader :id, :name, :description
  attr_writer :name, :description

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @name = params['name']
    @description = params['description']
  end

  def self.map_data(data_hash)
    result = data_hash.map { |data| self.new( data ) }
    return result
  end

  def save()
    sql = "INSERT INTO gymclasses (name, description)
      VALUES ($1, $2) RETURNING id;"
    values= [@name, @description]
    @id = SQLRunner.execute(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE gymclasses SET (name, description)
      = ($1, $2) WHERE id = $3;"
    values= [@name, @description, @id]
    SQLRunner.execute(sql, values)
  end

  def delete()
    sql = "DELETE FROM gymclasses WHERE id = $1;"
    values = [@id]
    SQLRunner.execute(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM gymclasses;"
    SQLRunner.execute(sql)
  end

  def self.find_by_id(the_id)
    sql = "SELECT * FROM gymclasses
      WHERE id = $1;"
    values = [the_id]
    return self.map_data(SQLRunner.execute(sql, values)).first
  end

  def self.all()
    sql = "SELECT gymclasses.* FROM gymclasses ORDER BY name;"
    return self.map_data(SQLRunner.execute(sql))
  end

  def schedule
    sql = "SELECT s.id, gc.name, gc.description, s.start_date, s.start_time, s.duration, s.max_attendees, count(b.*) attendees_booked
      FROM gymclasses gc
      INNER JOIN schedules s ON gc.id = s.gymclass_id
      LEFT JOIN bookings b ON b.schedule_id = s.id
      WHERE gc.id = $1
      GROUP BY s.id, gc.name, gc.description, s.start_date, s.start_time, s.duration, s.max_attendees
      ORDER BY s.start_date, s.start_time;"
    values = [@id]

    results = SQLRunner.execute(sql, values).to_a
    return results
  end

  def bookings()
    sql = "SELECT gc.name, s.start_date, s.start_time, s.duration, m.first_name, m.last_name
      FROM gymclasses gc
      INNER JOIN schedules s ON gc.id = s.gymclass_id
      INNER JOIN bookings b ON s.id = b.schedule_id
      INNER JOIN members m ON b.member_id = m.id
      WHERE gc.id = $1
      ORDER BY s.start_date, s.start_time;"
    values = [@id]
    results = SQLRunner.execute(sql, values).to_a
    return results
  end


end
