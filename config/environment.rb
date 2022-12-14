require 'bundler'
Bundler.require

APP_ROOT = File.expand_path('..', __dir__)

Dir.glob(File.join(APP_ROOT, 'app', 'controllers', '*.rb')).each { |file| require file }
Dir.glob(File.join(APP_ROOT, 'app', 'models', '*.rb')).each { |file| require file }

require File.join(APP_ROOT, 'config', 'database')
# configure SinatraPractice settings
class WishlistApp < Sinatra::Base
 set :method_override, true
 set :root, APP_ROOT
 set :views, File.join(APP_ROOT, "app", "views")
 set :public_folder, File.join(APP_ROOT, "app", "public")
end