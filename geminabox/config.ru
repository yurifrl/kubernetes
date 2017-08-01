require "rubygems"
require "geminabox"

Geminabox.data = "/data"
Geminabox.rubygems_proxy = true

use Rack::Auth::Basic, "Gem in a Box " do |username, password|
  username == ENV['GEMBOX_USER'] && password == ENV['GEMBOX_PASSWORD']
end

run Geminabox::Server
