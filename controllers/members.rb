
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/Member.rb' )
also_reload( '../models/*' )

get '/members' do
  @members = Member.all
  erb ( :"members/index" )
end

get '/members/:id/get' do
  @member = Member.find_by_id(params['id'])
  erb ( :"members/edit" )
end

get '/members/create' do
  erb( :"members/create" )
end


post '/members/:id' do
  member = Member.new(params)
  member.update
  redirect to "/members"
end

post '/members' do
  member = Member.new(params)
  member.save
  redirect to "/members"
end

post '/members/:id/delete' do
  member = Member.find_by_id(params['id'])
  member.delete()
  redirect to "/members"
end
