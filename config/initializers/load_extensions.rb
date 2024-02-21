# Load custom extensions
Dir[Rails.root.join('app', 'extensions', '*.rb')].each { |file| require file }