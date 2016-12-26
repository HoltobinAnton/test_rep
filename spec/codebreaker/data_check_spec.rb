require '../spec_helper'

describe 'DataCheck' do
  subject { Object.new.extend(CodeBreakerGemHoltobinAnton::DataCheck) }
  before(:each) do
    @game = CodeBreakerGemHoltobinAnton::Game.new
    @game.start
  end

  context '.data_checking?(data)' do
    array = [['1234', false],
             ['1234',  false],
             ['4444',  false],
             ['1212',  false],
             ['6111',  false],
             ['4440',  true],
             ['12121', true],
             ['6117',  true],
             ['',      true],
             ['test',  true],
             ['any_string', true]]
    array.each do |item|
      it 'for error checking, should return false or true' do
        expect(subject.data_checking?(item[0])).to be(item[1])
      end
    end
  end

  context '.check_victory?' do
    it 'should be true' do
      user_code = @game.secret_code.clone
      expect(@game.check_victory?(user_code)).to be(true)
    end

    it 'should be false' do
      user_code = @game.secret_code.clone.reverse
      expect(@game.check_victory?(user_code)).to be(false)
    end
  end

  context '.check_attempts_ended?' do
    it 'if no more attempts left' do
      @game.choice_did = 10
      @game.choice_size = 10
      expect(@game.check_attempts_ended?).to be(true)
    end

    it 'if choice_did < choice_size should return false' do
      @game.choice_did = 9
      @game.choice_size = 10
      expect(@game.check_attempts_ended?).to be(false)
    end
  end

  context '.responds by marking' do
    array = [['1234', '1234', '++++'],
             ['4444', '4444', '++++'],
             ['3331', '3332', '+++'],
             ['1113', '1112', '+++'],
             ['1312', '1212', '+++'],
             ['1234', '1266', '++'],
             ['1234', '6634', '++'],
             ['1234', '1654', '++'],
             ['1234', '1555', '+'],
             ['1234', '4321', '----'],
             ['5432', '2345', '----'],
             ['1234', '2143', '----'],
             ['1221', '2112', '----'],
             ['5432', '2541', '---'],
             ['1145', '6514', '---'],
             ['1244', '4156', '--'],
             ['1221', '2332', '--'],
             ['2244', '4526', '--'],
             ['5556', '1115', '-'],
             ['1234', '6653', '-'],
             ['3331', '1253', '--'],
             ['2345', '4542', '+--'],
             ['1243', '1234', '++--'],
             ['4111', '4444', '+'],
             ['1532', '5132', '++--'],
             ['3444', '4334', '+--'],
             ['1113', '2155', '+'],
             ['2245', '4125', '+--'],
             ['4611', '1466', '---'],
             ['5451', '4445', '+-']]
    array.each do |item|
      it "responds by marking #{item[0]} to #{item[1]} = #{item[2]}" do
        @game.check_for_match(item[0], item[1])
        expect(@game.result).to eq(item[2])
      end
    end
  end
end
