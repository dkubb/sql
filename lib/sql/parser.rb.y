# encoding: utf-8

# An SQL parser
class SQL::Parser

token select from as
      true false null
      left_paren right_paren
      comma period
      plus_sign minus_sign asterisk solidus
      E digit
      identifier

# Rule naming conventions follow the ANSI SQL-92 BNF grammar:
# http://savage.net.au/SQL/sql-92.bnf

rule
  default
    : query_specification

  sign
    : plus_sign
    | minus_sign

  subquery
    : left_paren query_expression right_paren

  query_expression
    : non_join_query_expression

  non_join_query_expression
    : non_join_query_term

  non_join_query_term
    : non_join_query_primary

  non_join_query_primary
    : simple_table
    | left_paren non_join_query_term right_paren

  simple_table
    : query_specification

  table_name
    : qualified_name

  qualified_name
    : qualified_identifier

  qualified_identifier
    : identifier

  column_name
    : identifier

  column_reference
    : qualifier period column_name
    | column_name

  qualifier
    : table_name

  correlation_name
    : identifier

  query_specification
    : query_specification table_expression
    | select select_list

  select_list
    : asterisk
    | select_list comma select_sublist
    | select_sublist

  select_sublist
    : derived_column
    | qualifier period asterisk

  derived_column
    : derived_column as_clause
    | value_expression

  as_clause
    : as column_name

  table_expression
    : from_clause

  from_clause
    : from table_reference
    | from derived_table_reference

  table_reference
    : table_reference correlation_specification
    | table_name

  derived_table_reference
    : derived_table correlation_specification

  derived_table
    : table_subquery

  table_subquery
    : subquery

  correlation_specification
    : as correlation_name

  value_expression
    : numeric_value_expression

  numeric_value_expression
    : term
    | numeric_value_expression plus_sign term
    | numeric_value_expression minus_sign term

  term
    : factor
    | term asterisk factor
    | term solidus factor

  factor
    : sign numeric_primary
    | numeric_primary

  numeric_primary
    : value_expression_primary

  value_expression_primary
    : unsigned_value_specification
    | column_reference
    | left_paren value_expression right_paren

  unsigned_value_specification
    : unsigned_literal

  unsigned_literal
    : unsigned_numeric_literal

  unsigned_numeric_literal
    : exact_numeric_literal
    | approximate_numeric_literal

  exact_numeric_literal
    : exact_numeric_literal period unsigned_integer
    | unsigned_integer

  unsigned_integer
    : digit

  approximate_numeric_literal
    : mantissa E exponent

  mantissa
    : exact_numeric_literal

  exponent
    : signed_integer

  signed_integer
    : sign unsigned_integer
    | unsigned_integer
end

---- inner

def initialize(scanner)
  @tokens = scanner.each
  super()
end

def parse
  do_parse
  self
end

def next_token
  @tokens.next
rescue StopIteration
  # return nil
end
