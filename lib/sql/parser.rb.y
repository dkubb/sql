# Rule naming conventions follow the ANSI SQL-92 BNF grammar:
# http://savage.net.au/SQL/sql-92.bnf

# An SQL parser
class SQL::Parser

token select from as
      true false null
      left_paren right_paren
      comma period
      plus_sign minus_sign asterisk solidus
      E unsigned_integer
      identifier

start
  query_specification

rule
  sign
    : plus_sign  { result = :uplus  }
    | minus_sign { result = :uminus }

  subquery
    : left_paren query_expression right_paren { result = val[1] }

  query_expression
    : non_join_query_expression

  non_join_query_expression
    : non_join_query_term

  non_join_query_term
    : non_join_query_primary

  non_join_query_primary
    : simple_table
    | left_paren non_join_query_term right_paren { result = val[1] }

  simple_table
    : query_specification

  table_name
    : qualified_name

  qualified_name
    : qualified_identifier

  qualified_identifier
    : identifier { result = s(:id, *val) }

  column_name
    : identifier { result = s(:id, *val) }

  column_reference
    : qualifier period column_name { result = val[0].concat(val[2]) }
    | column_name

  qualifier
    : table_name

  correlation_name
    : identifier { result = s(:id, *val) }

  query_specification
    : query_specification table_expression { result = val[0].append(val[1]) }
    | select select_list                   { result = s(:select, val[1])    }

  select_list
    : asterisk                         { result = s(:fields, s(:asterisk)) }
    | select_list comma select_sublist { result = val[0].append(val[2])    }
    | select_sublist                   { result = s(:fields, *val)         }

  select_sublist
    : derived_column
    | qualifier period asterisk { result = val[0].append(s(:asterisk)) }

  derived_column
    : derived_column as_clause { result = s(:as, *val) }
    | value_expression

  as_clause
    : as column_name { result = val[1] }

  table_expression
    : from_clause

  from_clause
    : from table_reference         { result = val[1] }
    | from derived_table_reference { result = val[1] }

  table_reference
    : table_reference correlation_specification { result = s(:as, *val) }
    | table_name

  derived_table_reference
    : derived_table correlation_specification { result = s(:as, *val) }

  derived_table
    : table_subquery

  table_subquery
    : subquery

  correlation_specification
    : as correlation_name { result = val[1] }

  value_expression
    : numeric_value_expression

  numeric_value_expression
    : term
    | numeric_value_expression plus_sign term  { result = s(:add, val[0], val[2]) }
    | numeric_value_expression minus_sign term { result = s(:sub, val[0], val[2]) }

  term
    : factor
    | term asterisk factor { result = s(:mul, val[0], val[2]) }
    | term solidus factor  { result = s(:div, val[0], val[2]) }

  factor
    : sign numeric_primary { result = s(*val) }
    | numeric_primary

  numeric_primary
    : value_expression_primary

  value_expression_primary
    : unsigned_value_specification
    | column_reference
    | left_paren value_expression right_paren { result = val[1] }

  unsigned_value_specification
    : unsigned_literal

  unsigned_literal
    : unsigned_numeric_literal

  unsigned_numeric_literal
    : exact_numeric_literal
    | approximate_numeric_literal

  exact_numeric_literal
    : exact_numeric_literal period unsigned_integer { result = s(:float, sprintf('%d.%d', *val[0], val[2]).to_f) }
    | unsigned_integer                              { result = s(:integer, val[0]) }

  approximate_numeric_literal
    : mantissa E exponent { result = s(:float, sprintf('%fE%d', *val[0], *val[2]).to_f) }

  mantissa
    : exact_numeric_literal

  exponent
    : signed_integer

  signed_integer
    : sign unsigned_integer {
      op = case val[0]
      when :uplus  then :+@
      when :uminus then :-@
      end
      result = s(:integer, val[1].public_send(op))
    }
    | unsigned_integer { result = s(:integer, *val) }
end

---- inner
include NodeHelper

attr_reader :result

def self.parse(input, scanner_class = Scanner)
  new(scanner_class.new(input)).parse
end

def initialize(scanner)
  @tokens = scanner.each
  super()
end

def parse
  @result ||= do_parse
  self
end

def next_token
  @tokens.next
rescue StopIteration
  # return nil
end
