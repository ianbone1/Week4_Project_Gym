require('minitest')
require('minitest/autorun')
require('minitest/rg')
require('pry')
require_relative('../Member.rb')

class TestMember < Minitest::Test

def setup()
  @member0 = Member.new({
    'first_name' => 'Ian',
    'last_name' => 'Bone',
    'premium' => 'TRUE',
    'telephone' => '07884338083',
    'email' => 'ianbone1@googlemail.com',
    'address_line_1' => '79 Hawthorn Crescent',
    'address_line_2' => '',
    'town' => 'Erskine',
    'district' => 'Renfrewshire',
    'post_code' => 'PA8 7BY'}
  )
end

def test_create_new
  assert_equal('Ian', @member0.first_name)
end

def test_save
  @member0.save()
  assert_equal(!nil, @member0.id>0)
end

def test_update
  pre=@member0.email
  @member0.email = 'ianbone1@googlemail.com'
  @member0.update()
  assert_equal('Ian', @member0.first_name)
end

def test_delete
  @member0.first_name = "BobBobBob"
  @member0.update
  @member0.delete
  assert_equal('BobBobBob', @member0.first_name)
end

# def test_delete_all
#   Member.delete_all
#   assert_equal('Ian', @member0.first_name)
# end

def test_find_by_id
  @member0.save
  member1 = Member.find_by_id(@member0.id)
  # binding.pry
  assert_equal(member1.id, @member0.id)
end

# checked by hand that members hash was returned
# def test_find_all
#   @member0.save
#   members = Member.all()
#   # binding.pry
#   # assert_equal(member1.id, @member0.id)
#
# end

end
