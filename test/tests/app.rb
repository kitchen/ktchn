require_relative '../test_helper'
require 'pry'

class KtchnTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Ktchn
  end

  def setup
  end

  def test_root
    get '/'
    assert(last_response.redirect?)
    assert_equal('https://words.kitchen.io/ktchn/',last_response.location)
  end
end
