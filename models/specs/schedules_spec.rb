require('minitest')
require('minitest/autorun')
require('minitest/rg')
require('pry')
require_relative('../Schedule.rb')
require_relative('../GymClass.rb')

class TestSchedule < Minitest::Test

  def setup()
    @gymclass0 = GymClass.new({
      'name' => 'Metafit',
      'description' => 'One of the hardest, killing classes ont he planet!',
      })
    @gymclass0.save

    @schedule0 = Schedule.new({
      'gymclass_id' => @gymclass0.id,
      'start_date' => '04/02/2019',
      'start_time' => '10:00:00',
      'duration' => '00:45:00',
      'max_attendees' => 5})
  end

  def test_save
    @schedule0.save
    assert_equal(!nil, @schedule0.id != nil)
  end

  def test_find_by_id
    @schedule0.save
    found_schedule = Schedule.find_by_id(@schedule0.id)
    assert_equal(@schedule0.gymclass_id, found_schedule.gymclass_id)
  end 
end
