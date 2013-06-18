# encoding: utf-8

require 'ast'
require 'ice_nine'
require 'adamantium'
require 'abstract_type'

# Library namespace
module SQL

  # Raised when a node type is unknown
  class UnknownTypeError < ArgumentError; end

end # SQL

require 'sql/ast/node'
require 'sql/fuzzer'

require 'sql/generator'
require 'sql/generator/stream'
require 'sql/generator/registry'
require 'sql/generator/constants'

require 'sql/generator/emitter'
require 'sql/generator/emitter/literal'
require 'sql/generator/emitter/literal/date'
require 'sql/generator/emitter/literal/datetime'
require 'sql/generator/emitter/literal/float'
require 'sql/generator/emitter/literal/integer'
require 'sql/generator/emitter/literal/singleton'
require 'sql/generator/emitter/literal/string'

require 'sql/generator/emitter/identifier'
require 'sql/generator/emitter/binary_operation'
require 'sql/generator/emitter/unary_scalar'

require 'sql/generator/emitter/tuple'
require 'sql/generator/emitter/insert'
require 'sql/generator/emitter/delete'

require 'sql/parser'
require 'sql/version'
require 'sql/node_helper'

# Finalize the emitter dispatch table
SQL::Generator::Emitter.finalize
