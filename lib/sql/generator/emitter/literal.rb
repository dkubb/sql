# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Namespace for literal emitters
      class Literal < self

        children :value

        # Returns an unfrozen object
        #
        # Some objects, like Date, DateTime and Time memoize values
        # when serialized to a String, so when they are frozen this will
        # dup them and then return the unfrozen copy.
        #
        # @param [Object] object
        #
        # @return [Object]
        #   non-frozen object
        #
        # @api private
        def self.unfrozen(object)
          object.frozen? ? object.dup : object
        end

      end # Literal

    end # Emitter
  end # Generator
end # SQL
