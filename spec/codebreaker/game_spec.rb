require '../spec_helper'

RSpec.describe 'Game' do
  before(:each) do
    @game = CodeBreakerGemHoltobinAnton::Game.new
    @game.start
  end

  context '.start' do
    it 'save secret code' do
      expect(@game.instance_variable_get(:@secret_code)).not_to be_empty
    end

    it 'save 4 numbers secret code' do
      expect(@game.instance_variable_get(:@secret_code)).to have(4).items
    end

    it 'should be eq regex ^[1-6]{4}$' do
      expect(@game.instance_variable_get(:@secret_code)).to match(/^[1-6]{4}$/)
    end
  end

  context '.hint' do
    it 'should be in a secret code' do
      hint_code = @game.hint
      expect(@game.secret_code).to include(hint_code)
    end

    it 'should be increment to 1' do
      expect { @game.hint }.to change { @game.hint_used }.by(1)
    end
  end

  context '.submit' do
    it 'choice_did should be equal to 0' do
      expect(@game.instance_variable_get(:@choice_did)).to eq(0)
    end

    it 'should  be increment by 1' do
      @game.stub(:gets).and_return('1234')
      expect { @game.submit('2341') }.to change { @game.choice_did }.by(1)
    end
  end
end
