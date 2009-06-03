# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../me'
%w(test/unit rack/test).each { |l| require l }
class MeTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Me.new
  end
  
  def test_me
    get '/'
  end
end