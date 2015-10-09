require 'active_support/concern'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/inclusion'

module EnumeratedConstants
  extend ActiveSupport::Concern

  # Methods added to the class upon include
  module ClassMethods
    def all
      @all ||= constants.map(&method(:const_get)).delete_if do |constant|
        constant == ClassMethods || constant.is_a?(Array)
      end.freeze
    end

    delegate :each, :include?, :map, :sample, :sort, to: :all

    # Return all but the constant name you pass
    # @param name [Symbol,String] The name of the constant you don't want
    # @return [Array] @all except the value of that constant
    def except(*names)
      const_names =
      names = names.map(&:upcase).map(&:to_sym)
      values = names.map do |name|
        begin
          const_get(name)
        rescue NameError
        end
      end.compact
      all - values
    end
  end
end
