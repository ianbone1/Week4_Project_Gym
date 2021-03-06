
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/GymClass.rb' )
also_reload( '../models/*' )

# show schedules
get '/gymclasses/schedules/:id' do
  #id is a gymclass id
  @gymclass = GymClass.find_by_id(params['id'])
  @schedules = @gymclass.schedule()
  erb ( :"/gymclasses/schedule/index" )
end

# edit schedule
get '/gymclasses/schedule/:id/edit' do
  @schedule = Schedule.find_by_id(params['id'].to_i)
  @gymclass = GymClass.find_by_id(@schedule.gymclass_id)
  erb( :"/gymclasses/schedule/edit" )
end

#create/save a new schedule
post '/gymclasses/schedule' do
  new_schedule = Schedule.new(params)
  # binding.pry
  new_schedule.save
  refresh = "/gymclasses/schedules/" + params['gymclass_id'].to_s
  redirect to refresh
end

#display the create panel that feeds the above post
get '/gymclasses/schedule/:id/create' do
  @gymclass = GymClass.find_by_id(params['id'])
  erb( :"/gymclasses/schedule/create" )
end

#delete schedules
post '/gymclasses/schedule/:id/delete' do
  gymclass = Schedule.find_by_id(params['id'])
  gymclass.delete()
  redirect to "/gymclasses"
end



#do the update to the database for schedule changes
post '/gymclasses/schedule/:id' do
  updated_schedule = Schedule.new(params)
  updated_schedule.update
  refresh = "/gymclasses/schedules/" + params['gymclass_id'].to_s
  redirect to refresh
end
