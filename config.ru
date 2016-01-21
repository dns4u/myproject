
 require './index' 
 run Sinatra::Application
 set :database, ENV['DATABASE_URL'] || 'DataMapper.setup(:default,"postgres://postgres:dinesh 770@localhost/usershare")'
