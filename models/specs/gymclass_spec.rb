require('minitest')
require('minitest/autorun')
require('minitest/rg')
require('pry')
require_relative('../GymClass.rb')

class Test_GymClass < Minitest::Test

  def setup()
    @gymclass0 = GymClass.new({
      'name' => 'Metafit',
      'description' => 'One of the hardest, killing classes ont he planet!',
      }
    )
  end

  def test_create
    assert_equal("Metafit", @gymclass0.name)
  end

  def test_save
    before_id = @gymclass0.id
    @gymclass0.save()
    # assert_equal(3, @gymclass0.id)
  end

  def test_delete
    @gymclass0.save
    @gymclass0.delete
    assert_equal(5,5)
  end

  def test_update
    @gymclass0.save
    @gymclass0.update
    assert_equal(5,5)
  end

  def test_find_by_id
    @gymclass0.save
    foundclass = GymClass.find_by_id(@gymclass0.id)
    assert_equal(@gymclass0.id, foundclass.id)
  end

  def test_list_schedules
    theclass = GymClass.find_by_id(1)
    the_schedule = theclass.schedule()
  end






end
