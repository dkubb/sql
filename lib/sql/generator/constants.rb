# encoding: utf-8

module SQL
  module Generator

    # Constants included in the emitter classes
    #
    # @private
    module Constants

      # Keywords
      K_TRUE     = 'TRUE'.freeze
      K_FALSE    = 'FALSE'.freeze
      K_NULL     = 'NULL'.freeze
      K_SELECT   = 'SELECT'.freeze
      K_WHERE    = 'WHERE'.freeze
      K_FROM     = 'FROM'.freeze
      K_GROUP_BY = 'GROUP BY'.freeze
      K_HAVING   = 'HAVING'.freeze
      K_ORDER_BY = 'ORDER BY'.freeze
      K_UPDATE   = 'UPDATE'.freeze
      K_SET      = 'SET'.freeze
      K_INSERT   = 'INSERT'.freeze
      K_INTO     = 'INTO'.freeze
      K_VALUES   = 'VALUES'.freeze
      K_DELETE   = 'DELETE'.freeze

      # Unary Prefix Operators
      O_NEGATION = 'NOT'.freeze
      O_ON       = 'ON'.freeze
      O_USING    = 'USING'.freeze

      # Unary Function Operators
      O_COUNT  = 'COUNT'.freeze
      O_SUM    = 'SUM'.freeze
      O_MIN    = 'MIN'.freeze
      O_MAX    = 'MAX'.freeze
      O_AVG    = 'AVG'.freeze
      O_VAR    = 'VAR_POP'.freeze
      O_STDDEV = 'STDDEV_POP'.freeze
      O_SQRT   = 'SQRT'.freeze
      O_ABS    = 'ABS'.freeze
      O_LENGTH = 'LENGTH'.freeze

      # Binary Infix Operators
      O_AND      = 'AND'.freeze
      O_OR       = 'OR'.freeze
      O_IN       = 'IN'.freeze
      O_BETWEEN  = 'BETWEEN'.freeze
      O_PLUS     = '+'.freeze
      O_MINUS    = '-'.freeze
      O_MULTIPLY = '*'.freeze
      O_DIVIDE   = '/'.freeze
      O_MOD      = '%'.freeze
      O_POW      = '^'.freeze
      O_IS       = 'IS'.freeze
      O_EQ       = '='.freeze
      O_NE       = '<>'.freeze
      O_GT       = '>'.freeze
      O_GTE      = '>='.freeze
      O_LT       = '<'.freeze
      O_LTE      = '<='.freeze
      O_CONCAT   = '||'.freeze

      # Set Operators
      O_EXCEPT    = 'EXCEPT'.freeze
      O_INTERSECT = 'INTERSECT'.freeze
      O_UNION     = 'UNION'.freeze

      # Join Operators
      O_JOIN         = 'JOIN'.freeze
      O_LEFT_JOIN    = 'LEFT JOIN'.freeze
      O_RIGHT_JOIN   = 'RIGHT JOIN'.freeze
      O_FULL_JOIN    = 'FULL JOIN'.freeze
      O_NATURAL_JOIN = 'NATURAL JOIN'.freeze
      O_CROSS_JOIN   = 'CROSS JOIN'.freeze

      # Sort Operators
      O_ASC  = 'ASC'.freeze
      O_DESC = 'DESC'.freeze

      # Delimiters
      D_QUOTE             = %q['].freeze
      D_ESCAPED_QUOTE     = %q[''].freeze
      D_DBL_QUOTE         = '"'.freeze
      D_ESCAPED_DBL_QUOTE = '""'.freeze
      D_PERIOD            = '.'.freeze
      D_COMMA             = ','.freeze

      BRACES_L      = '{'.freeze
      BRACES_R      = '}'.freeze
      PARENTHESIS_L = '('.freeze
      PARENTHESIS_R = ')'.freeze

      WS = ' '.freeze
      NL = "\n".freeze

    end # Constants
  end # Generator
end # SQL
