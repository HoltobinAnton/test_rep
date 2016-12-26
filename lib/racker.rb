require 'erb'
require 'yaml'
require_relative '../lib/code_breaker_gem_holtobin_anton/game.rb'
class Racker
  attr_accessor :hint, :result
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def response
    case @request.path
    when '/' then Rack::Response.new(render('index.html.erb'))
    when '/start' then start
    when '/data_check' then data_check
    when '/save' then save
    when '/get_hint' then get_hint
    else Rack::Response.new('Not Found', 400)
    end
  end

  def start
    @request.session.clear
    main.start
    render_game
  end

  def data_check
    user_code = @request.params['user_code']
    return render_game if main.data_checking?(user_code)
    return Rack::Response.new(render('the_end.html.erb')) if main.inspection_game?(user_code)
    main.submit(user_code)
    @result = main.result
    render_game
  end

  def get_hint
    @hint = main.hint
    render_game
  end

  def render_game
    Rack::Response.new(render('game.html.erb'))
  end

  def main
    @request.session[:main] ||= CodeBreakerGemHoltobinAnton::Game.new
  end

  def choice_size
    @choice_size ||= main.choice_size
  end

  def choice_did
    @choice_did ||= main.choice_did
  end

  def hint_used
    @hint_used ||= main.hint_used
  end

  def secret_code
    @secret_code ||= main.secret_code
  end

  def steps_history
    @steps_history ||= main.steps_res_history
  end

  def load_games
    @load_games ||= main.load_games
  end

  def save
    user_code = @request.params['name_code']
    main.end_game(user_code)
    Rack::Response.new(render('index.html.erb'))
  end
end
