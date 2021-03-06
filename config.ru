require './lib/racker'
use Rack::Reloader
use Rack::Static, urls: ['/stylesheets'], root: 'public'

use Rack::Session::Cookie, key: 'rack.session',
                           path: '/',
                           secret: 'none'
run Racker
