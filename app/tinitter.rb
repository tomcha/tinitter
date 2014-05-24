require 'sinatra/base'
require 'haml'
require 'active_record'
require_relative 'db'
require_relative 'models/post'

class Tinitter < Sinatra::Base
  configure do
    DB.connect(
      File.expand_path(File.join(root, '..')),
      ENV['RACK_ENV'])
  end

  set :public_folder, File.expand_path(File.join(root, '..', 'public'))

  get '/' do
    @posts = Post.order('id DESC')
    haml :index
  end

  post '/post/commit' do
    if params[:nickname].to_s !~ (/\A[0-9a-zA-Z]+\z/)
      redirect '/'
    elsif params[:body].length > 1000
      redirect '/'
    end
    Post.create!(nickname: params[:nickname], body: params[:body])
      redirect '/'
  end
end
