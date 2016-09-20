shared_context 'variables are initialized' do |arguments, *names|
  names.each do |key|
    let(key) { arguments[key.to_sym]  }
  end
end
