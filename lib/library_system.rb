require_relative 'config/initializer'
require_relative 'models/book'
require_relative 'models/library'
require_relative 'models/member'
require_relative 'models/transaction'
require_relative 'services/book_service'
require_relative 'services/member_service'
require_relative 'persistence/storage'
require_relative 'cli'

module LibrarySystem
  class Application
    def self.start
      config = Configuration.load_config
      library = Library.new(name: "Digital Library")
      LibraryCLI.new(library).start
    end
  end
end

LibrarySystem::Application.start if __FILE__ == $PROGRAM_NAME 