# encoding: utf-8

module SQL
  module Generator

    # Constants included in the emitter classes
    #
    # @api private
    module Constants
      CB_L           = '{'.freeze
      CB_R           = '}'.freeze
      CURLY_BRACKETS = [ CB_L, CB_R ].freeze

      BRACKET_L = '('.freeze
      BRACKET_R = ')'.freeze
      BRACKETS  = [ BRACKET_L, BRACKET_R ].freeze

      WS = ' '.freeze
      NL = "\n".freeze

      # Keywords
      K_TRUE  = 'TRUE'.freeze
      K_FALSE = 'FALSE'.freeze
      K_NULL  = 'NULL'.freeze
      K_AND   = 'AND'.freeze
      K_OR    = 'OR'.freeze

      # Operators
      O_PLUS     = '+'.freeze
      O_MINUS    = '-'.freeze
      O_NEGATION = '!'.freeze

      # Delimiters
      D_QUOTE             = %q(').freeze
      D_ESCAPED_QUOTE     = %q('').freeze
      D_DBL_QUOTE         = %q(").freeze
      D_ESCAPED_DBL_QUOTE = %q("").freeze
      DEFAULT_DELIMITER   = ', '.freeze

    end # Constants

  end # Generator
end # SQL
