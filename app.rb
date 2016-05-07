require 'sinatra/base'

class Ktchn < Sinatra::Base
  get '/' do
    redirect to('https://words.kitchen.io/ktchn/')
  end
end
