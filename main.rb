# encoding: UTF-8
require 'json'
require 'sinatra'
require 'data_mapper'
require 'dm-migrations'
require 'sinatra/flash'

enable :sessions

configure :development do
   DataMapper.setup(
    :default,
    'postgres://cisco:cisco123@localhost/test'
  )
end


configure :production do
  DataMapper.setup(
    :default,
    'postgres://postgres:12345@localhost/sinatra_service'
  )
end



require './models/init'
require './helpers/init'
require './routes/init'

DataMapper.finalize 