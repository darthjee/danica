# frozen_string_literal: true

shared_context 'when variables are initialized' do |arguments, *names|
  names.each do |key|
    let(key) { arguments[key.to_sym] }
  end
end
