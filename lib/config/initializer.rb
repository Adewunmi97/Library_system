require 'yaml'
require 'json'

module LibrarySystem
  class Configuration
    class << self
      def load_config
        @config ||= begin
          YAML.load_file(File.join(__dir__, 'config.yml'))
        rescue Errno::ENOENT
          default_config
        end
      end

      private

      def default_config
        {
          'loan_period_days' => 14,
          'max_borrowed_books' => 5,
          'daily_late_fee' => 1.0
        }
      end
    end
  end
end 