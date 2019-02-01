
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/GymClass.rb' )
also_reload( '../models/*' )

get '/gymclasses' do
  @gymclasses = GymClass.all
  erb ( :"gymclasses/index" )
end

get '/gymclasses/:id/get' do
  @gymclass = GymClass.find_by_id(params['id'])
  erb ( :"gymclasses/edit" )
end

get '/gymclasses/create' do
  erb( :"gymclasses/create" )
end


post '/gymclasses/:id' do
  gymclass = GymClass.new(params)
  gymclass.update
  redirect to "/gymclasses"
end

post '/gymclasses' do
  gymclass = GymClass.new(params)
  gymclass.save
  redirect to "/gymclasses"
end

post '/gymclasses/:id/delete' do
  gymclass = GymClass.find_by_id(params['id'])
  gymclass.delete()
  redirect to "/gymclasses"
end
