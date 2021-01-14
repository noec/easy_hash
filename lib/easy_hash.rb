# frozen_string_literal: true

require_relative "easy_hash/version"

module EasyHash
  class HashToObject
    attr_reader :hash

    def initialize(hash)
      @hash = hash
    end

    def method_missing(method, *)
      hash_object = hash[method.to_sym]
      return super if hash_object.nil?
      return self.class.new(hash_object) if hash_object.is_a?(Hash)
      return convert_to_array_of_objects(hash_object) if hash_object.is_a?(Array)

      hash_object
    end

    def respond_to_missing?(method, *)
      return super if hash.nil? || hash[method.to_sym].nil?

      hash[method.to_sym]
    end

    def to_h
      hash
    end

    private

    def convert_to_array_of_objects(hash_object)
      hash_object.map { |ha| self.class.new(ha) }
    end
  end
end
