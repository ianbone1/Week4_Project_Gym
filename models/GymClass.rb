require_relative('../db/SQLRunner.rb')

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
    sql = "SELECT gymclasses.* FROM gymclasses;"
    return self.map_data(SQLRunner.execute(sql))
  end


end
