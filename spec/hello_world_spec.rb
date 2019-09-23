require 'hello_world.rb'
describe HelloWorld do
  it 'speaks' do
    expect(subject.speak).to eq('Hello, world!')
  end
end
