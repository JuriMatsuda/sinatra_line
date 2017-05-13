require 'bundler'
Bundler.require

require './models/user.rb'

module Line
  class App < Sinatra::Base

    register Sinatra::ActiveRecordExtension

    use Rack::Session::Memcache, autofix_keys: true, secret: 'line'


    use Warden::Manager do |manager|
      manager.default_strategies :custom_login_strategy
      manager.failure_app = Sinatra::Application
    end

    helpers do
      def login?
        !session[:uid].nil?
      end

      def username
        login? ? User.find(session[:uid]).name : 'Guest'
      end
    end


    get '/' do
      @users = User.all
      erb :index, locals: { users: @users, me: username }
    end

    get '/signup' do
      erb :signup
    end

    post '/signup' do
      user = User.new do |u|
        u.name = params[:name]
        u.password = params[:password]
        u.email = params[:email]
      end

      if user.valid? && user.save
        session[:uid] = user.id
        redirect '/'
      else
        redirect back
      end
    end

    get '/login' do
      erb :login
    end

    post '/login' do
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:uid] = user.id
        redirect '/'
      else
        erb :login
      end
    end

    get '/logout' do
      session.destroy
      redirect '/'
    end

    get '/talk' do
      @topics = Topic.all
      erb :talk
    end

    post '/talk' do
      Comment.create(
          topic_id: params[:topic_id],
          body: params[:body]
      )

      redirect "/topic/#{params[:topic_id]}"
    end

  end
end
