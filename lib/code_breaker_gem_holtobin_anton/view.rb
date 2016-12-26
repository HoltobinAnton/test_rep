module CodeBreakerGemHoltobinAnton
  module View
    def end_game_mess(options = {}, str = '', name = '')
      "#{name} choice did #{options[:ch_did]} out of #{options[:ch_size]}." \
        "Hint used = #{options[:ht_size]} #{str}\n"
    end
  end
end
