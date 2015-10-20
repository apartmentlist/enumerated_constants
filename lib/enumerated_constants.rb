require 'forwardable'

# Mix-in that allows you to treat a module of related constants like
# a good ol' fashioned enum.
module EnumeratedConstants
  extend Forwardable

  def all
    @all ||= constants.map(&method(:const_get)).delete_if do |constant|
      constant.is_a?(Array)
    end.freeze
  end

  def_delegators :all, :each, :include?, :map, :sample, :sort

  # Return all but the constant name you pass
  # @param name [Symbol,String] The name of the constant you don't want
  # @return [Array] @all except the value of that constant
  def except(*names)
    names = names.map(&:upcase).map(&:to_sym)
    values = names.map do |name|
      begin
        const_get(name)
      rescue NameError
        raise ArgumentError, "Constant #{name} does not exist"
      end
    end.compact
    all - values
  end
end
