
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/GymClass.rb' )
require_relative( '../models/Booking.rb')
also_reload( '../models/*' )


#delete booking
post '/gymclasses/bookings/:id/delete' do
  booking = Booking.find_by_id(params['id'].to_i)
  # binding.pry
  booking.delete()
  refreshed_page = "/gymclasses/bookings/" + booking.schedule_id.to_s
  redirect to refreshed_page
end

# show bookings
get '/gymclasses/bookings/:id' do
  #id is a schedule id
  @schedule = Schedule.find_by_id(params['id'])
  @bookings = @schedule.bookings()
  erb ( :"/gymclasses/bookings/index" )
end

#create booking, schedule known

get '/gymclasses/bookings/:id/create-from-schedule' do
  #is is a class schedule_id
  @schedule = Schedule.find_by_id(params['id'].to_i)
  
  @gymclass = GymClass.find_by_id(@schedule.gymclass_id)
  @members = Member.all
  # binding.pry
  erb ( :"/gymclasses/bookings/create-from-schedule" )
end

#save the new booking
post '/gymclasses/bookings/create-from-schedule' do
  # binding.pry
  new_booking = Booking.new(params)
  # binding.pry
  new_booking.save
  refresh = "/gymclasses/bookings/" + params['schedule_id'].to_s
  redirect to refresh
end

# # edit schedule
# get '/gymclasses/schedule/:id' do
#   @schedule = Schedule.find_by_id(params['id'].to_i)
#   @gymclass = GymClass.find_by_id(@schedule.gymclass_id)
#   erb( :"gymclasses/schedule/edit" )
# end
# #delete schedules
# post '/gymclasses/schedule/:id/delete' do
#   gymclass = Schedule.find_by_id(params['id'])
#   gymclass.delete()
#   redirect to "/gymclasses"
# end
#
# #do the update to the database for schedule changes
# post '/gymclasses/schedule/:id' do
#   updated_schedule = Schedule.new(params)
#   updated_schedule.update
#   refresh = "/gymclasses/schedules/" + params['gymclass_id'].to_s
#   redirect to refresh
# end
#
# post '/gymclasses/schedule' do
#   new_schedule = Schedule.new(params)
#   new_schedule.save
#   refresh = "/gymclasses/schedules/" + params['gymclass_id'].to_s
#   redirect to refresh
# end
#
# get '/gymclasses/schedule/:id/create' do
#   @gymclass = GymClass.find_by_id(params['id'])
#   erb( :"gymclasses/schedule/create" )
# end
