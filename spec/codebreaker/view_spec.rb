require '../spec_helper'

describe 'View' do
  before(:each) do
    @game = CodeBreakerGemHoltobinAnton::Game.new
    @game.start
  end

  context '.restart_game?' do
    array = [
      ['Yes', true],
      ['yes', true],
      ['No',  false],
      ['',    false],
      ['Any', false]
    ]

    array.each do |item|
      it 'Do you want to start again' do
        @game.stub(:gets).and_return(item[0])
        expect(@game.restart_game_mess?).to be(item[1])
      end
    end
  end
end
