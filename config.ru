%w(rubygems rack rack-flash me).each { |l| require l } 

use Rack::ShowExceptions
#use Rack::Reloader
use Rack::Session::Cookie
use Rack::Flash, :accessorize => [:notice]
run Me