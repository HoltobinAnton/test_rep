require_relative 'data_check.rb'
require_relative 'game_io.rb'
require_relative 'view.rb'

module CodeBreakerGemHoltobinAnton
  class Game
    attr_accessor :user_code, :choice_did, :hint_used, :choice_size, :secret_code, :result, :steps_res_history
    SECRET_CODE_SIZE = 4
    CHOICE_SIZE = 5
    include(DataCheck)
    include(View)

    def initialize
      @choice_size = CHOICE_SIZE
      @secret_code = ''
      @user_code = ''
      @result = ''
      @hint_used = 0
      @choice_did = 0
      @steps_res_history = {}
    end

    def start
      @secret_code = Array.new(SECRET_CODE_SIZE) { 1 + rand(6) }.join
    end

    def submit(user_code)
      @result = ''
      @choice_did += 1
      @user_code = user_code
      check_for_match(@secret_code, user_code.to_s)
      step_history
    end

    def step_history
      @steps_res_history[@user_code] = @result
    end

    def inspection_game?(user_code)
      return true if check_attempts_ended? || check_victory?(user_code)
      false
    end

    def end_game(name = '')
      opt = game_info
      str = ''
      str += check_victory?(@user_code) ? end_game_mess(opt, 'won', name) : end_game_mess(opt, 'lost', name)
      ServiceIO.save_game(str)
    end

    def load_games
      ServiceIO.load_games
    end

    def game_info
      options = { ch_did:   @choice_did,
                  ch_size:  @choice_size,
                  ht_size:  @hint_used,
                  sec_code: @secret_code }
    end

    def hint
      @hint_used += 1
      @secret_code.chars.sample
    end
  end
end
