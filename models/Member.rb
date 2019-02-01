require_relative('../db/SQLRunner.rb')

class Member

  attr_reader :id, :first_name, :last_name, :premium, :telephone, :email, :address_line_1, :address_line_2, :town, :district, :post_code
  attr_writer :first_name, :last_name, :premium, :telephone, :email, :address_line_1, :address_line_2, :town, :district, :post_code

  def initialize(params)
    @id = params['id'].to_i if params['id'].to_i
    @first_name = params['first_name']
    @last_name = params['last_name']
    @premium = params['premium']
    @telephone = params['telephone']
    @email = params['email']
    @address_line_1 = params['address_line_1']
    @address_line_2 = params['address_line_2']
    @town = params['town']
    @district = params['district']
    @post_code = params['post_code']
  end

  def self.map_data(data_hash)
    result = data_hash.map { |data| self.new( data ) }
    return result
  end

  def save()
    sql = "INSERT INTO members (first_name, last_name, premium,
      telephone, email, address_line_1, address_line_2,
      town, district, post_code)
      VALUES ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      RETURNING id;"
    values = [@first_name, @last_name, @premium, @telephone, @email,
      @address_line_1, @address_line_2, @town, @district, @post_code]
    @id = SQLRunner.execute(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE members SET (first_name, last_name, premium,
      telephone, email, address_line_1, address_line_2,
      town, district, post_code) =
       ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10 )
      WHERE id = $11;"
    values = [@first_name, @last_name, @premium, @telephone, @email.to_s, @address_line_1, @address_line_2, @town, @district, @post_code, @id]
    SQLRunner.execute(sql, values)
  end

  def delete()
    sql = "DELETE FROM members WHERE id = $1;"
    values = [@id]
    SQLRunner.execute(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM members;"
    SQLRunner.execute(sql)
  end

  def self.find_by_id(the_id)
    sql = "SELECT members.* FROM members WHERE id = $1;"
    values = [the_id]
    # binding.pry
    return self.map_data(SQLRunner.execute(sql, values)).first
  end

  def self.all
    sql = "SELECT members.* FROM members;"
    return self.map_data(SQLRunner.execute(sql))
  end

end
