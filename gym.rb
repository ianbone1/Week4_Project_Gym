require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/members.rb')
require_relative('controllers/gymclasses.rb')
require_relative('controllers/schedules.rb')

get '/' do
  erb( :index )
end
