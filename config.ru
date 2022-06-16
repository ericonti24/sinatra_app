require './config/environment'

use Rack::MethodOverride
use SportsController
use UsersController
run ApplicationController
