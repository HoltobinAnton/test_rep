require './spec_helper'

RSpec.describe Racker do
subject { Rack::MockRequest.new(Racker) }

  %w(/ /start /data_check /save /get_hint).each  do |item|
  specify 'get responce 200' do
      expect(subject.get(item).status).to eq 200
    end
  end

  specify 'get responce 400' do
    expect(subject.get('/test').status).to eq 400
  end

  specify 'check button' do
    expect(subject.get('/').body).to match(/<input type="submit" value="Start Game">/)
    expect(subject.get('/save').body).to match(/<input type="submit" value="Start Game">/)
  end

  specify 'main div' do
    expect(subject.get('/start').body).to match(/<div id="container">/)
  end

  specify 'Chances size: 5' do
    5.times do
      subject.post('/data_check', { data_check: '3154' })
    end
    expect(subject.get('/start').body).to match(/Chances size: 5/)
end

end
