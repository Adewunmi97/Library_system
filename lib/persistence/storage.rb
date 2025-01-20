require 'json'

module Persistence
  class Storage
    def initialize(file_path)
      @file_path = file_path
    end

    def save(data)
      File.write(@file_path, JSON.pretty_generate(data))
    end

    def load
      return {} unless File.exist?(@file_path)
      JSON.parse(File.read(@file_path))
    end
  end
end 