# encoding: utf-8

module SQL
  module Generator

    # Constants included in the emitter classes
    #
    # @api private
    module Constants
      BRACES_L = '{'.freeze
      BRACES_R = '}'.freeze
      BRACES   = [BRACES_L, BRACES_R].freeze

      PARENTHESIS_L = '('.freeze
      PARENTHESIS_R = ')'.freeze
      PARENTHESIS   = [PARENTHESIS_L, PARENTHESIS_R].freeze

      WS = ' '.freeze
      NL = "\n".freeze
      SC = ';'.freeze

      # Keywords
      K_TRUE  = 'TRUE'.freeze
      K_FALSE = 'FALSE'.freeze
      K_NULL  = 'NULL'.freeze
      K_AND   = 'AND'.freeze
      K_OR    = 'OR'.freeze
      K_WHERE = 'WHERE'.freeze

      # Operators
      O_PLUS     = '+'.freeze
      O_MINUS    = '-'.freeze
      O_NEGATION = '!'.freeze

      # Delimiters
      D_QUOTE             = %q['].freeze
      D_ESCAPED_QUOTE     = %q[''].freeze
      D_DBL_QUOTE         = '"'.freeze
      D_ESCAPED_DBL_QUOTE = '""'.freeze
      DEFAULT_DELIMITER   = ', '.freeze

    end # Constants

  end # Generator
end # SQL
