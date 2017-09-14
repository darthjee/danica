shared_examples 'an object that respond to basic_methods' do |ignore: [], methods: %i(to_f to_tex to_gnu valued?)|
  (methods - ignore).each do |method|
    it {expect(subject).to respond_to(method) }
  end
end

