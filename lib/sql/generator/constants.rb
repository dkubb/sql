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
      K_TRUE     = 'TRUE'.freeze
      K_FALSE    = 'FALSE'.freeze
      K_NULL     = 'NULL'.freeze
      K_SELECT   = 'SELECT'.freeze
      K_WHERE    = 'WHERE'.freeze
      K_FROM     = 'FROM'.freeze
      K_GROUP_BY = 'GROUP BY'.freeze
      K_UPDATE   = 'UPDATE'.freeze
      K_SET      = 'SET'.freeze
      K_INSERT   = 'INSERT INTO'.freeze
      K_VALUES   = 'VALUES'.freeze
      K_DELETE   = 'DELETE'.freeze

      # Operators
      O_AND      = 'AND'.freeze
      O_OR       = 'OR'.freeze
      O_NEGATION = 'NOT'.freeze
      O_COUNT    = 'COUNT'.freeze
      O_SUM      = 'SUM'.freeze
      O_MIN      = 'MIN'.freeze
      O_MAX      = 'MAX'.freeze
      O_AVG      = 'AVG'.freeze
      O_VAR      = 'VAR_POP'.freeze
      O_STDDEV   = 'STDDEV_POP'.freeze
      O_SQRT     = 'SQRT'.freeze
      O_ABS      = 'ABS'.freeze
      O_PLUS     = '+'.freeze
      O_MINUS    = '-'.freeze
      O_MULTIPLY = '*'.freeze
      O_DIVIDE   = '/'.freeze
      O_MOD      = '%'.freeze
      O_POW      = '^'.freeze
      O_CONCAT   = '||'.freeze
      O_EQ       = '='.freeze
      O_NE       = '<>'.freeze
      O_GT       = '>'.freeze
      O_GTE      = '>='.freeze
      O_LT       = '<'.freeze
      O_LTE      = '<='.freeze
      O_IS       = 'IS'.freeze

      # Delimiters
      D_QUOTE             = %q['].freeze
      D_ESCAPED_QUOTE     = %q[''].freeze
      D_DBL_QUOTE         = '"'.freeze
      D_ESCAPED_DBL_QUOTE = '""'.freeze
      DEFAULT_DELIMITER   = ', '.freeze

    end # Constants

  end # Generator
end # SQL
