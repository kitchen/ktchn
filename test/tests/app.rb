require_relative '../test_helper'
require 'pry'

class KtchnTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Ktchn
  end

  def test_root
    get '/'
    assert(last_response.redirect?)
    assert_equal(last_response.location, 'https://words.kitchen.io/ktchn/')
  end

  def test_words
    get '/w2A'

    assert(last_response.redirect?, 'should be a redirect')
    assert_equal(last_response.location, 'https://words.kitchen.io/?p=130', 'should be a redirect to words.kitchen.io')
  end

  def test_404
    # first char will always be a letter, so this will always fail
    get '/123'

    assert(last_response.not_found?, 'should be a 404 page')
  end

end
