# encoding: utf-8

require 'singleton'

require 'ast'
require 'ice_nine'
require 'adamantium'
require 'abstract_type'

# Library namespace
module SQL

  # Raised when a node type is unknown
  class UnknownTypeError < ArgumentError

    # Initialize the unknown type error exception
    #
    # @param [Symbol] type
    #
    # @return [undefined]
    #
    # @api private
    def initialize(type)
      super("No emitter for node: #{type.inspect}")
    end

  end # UnknownTypeError
end # SQL

require 'sql/ast/node'
require 'sql/fuzzer'

require 'sql/constants'
require 'sql/generator'

require 'sql/generator/stream'
require 'sql/generator/registry'

require 'sql/generator/emitter/dsl'
require 'sql/generator/emitter/conditional_parenthesis'

require 'sql/generator/emitter'
require 'sql/generator/emitter/root'

require 'sql/generator/emitter/literal'
require 'sql/generator/emitter/literal/date'
require 'sql/generator/emitter/literal/datetime'
require 'sql/generator/emitter/literal/decimal'
require 'sql/generator/emitter/literal/float'
require 'sql/generator/emitter/literal/integer'
require 'sql/generator/emitter/literal/singleton'
require 'sql/generator/emitter/literal/string'
require 'sql/generator/emitter/literal/time'

require 'sql/generator/emitter/binary_connective_operation'
require 'sql/generator/emitter/binary_infix_operation'
require 'sql/generator/emitter/unary_function_operation'
require 'sql/generator/emitter/unary_prefix_operation'

require 'sql/generator/emitter/identifier'
require 'sql/generator/emitter/delimited'
require 'sql/generator/emitter/fields'
require 'sql/generator/emitter/predicate'
require 'sql/generator/emitter/sort_operation'
require 'sql/generator/emitter/tuple'
require 'sql/generator/emitter/update_set'

require 'sql/generator/emitter/insert'
require 'sql/generator/emitter/delete'
require 'sql/generator/emitter/update'
require 'sql/generator/emitter/select'

require 'sql/generator/emitter/set'
require 'sql/generator/emitter/join'

require 'sql/version'
require 'sql/node_helper'

require 'sql/scanner'
require 'sql/parser'

# Finalize the emitter dispatch table
SQL::Generator::Emitter.finalize
