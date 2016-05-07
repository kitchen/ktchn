require '../test_helper'
require 'pry'

class KtchnTest < Minitest::Test
  include Rack::Test::Methods

  def setup
  end

  def test_root
    get '/'
    binding.pry
    
  end


end
