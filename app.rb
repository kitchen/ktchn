require 'sinatra/base'
require 'new_base_60'

class Ktchn < Sinatra::Base
  get '/' do
    redirect to('https://words.kitchen.io/ktchn/')
  end

  get '/w*' do
    id = NewBase60.new(params['splat'][0])
    redirect to("https://words.kitchen.io/?p=#{id.to_i}")
  end

end
