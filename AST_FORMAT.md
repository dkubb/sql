AST Format
==========

## Literals

### Singletons

Format:

~~~
(true)
"TRUE"

(false)
"FALSE"

(null)
"NULL"
~~~

### String

~~~
(string "foo")
"'foo'"

# Quoted delimiter
(string "fo'o")
"'fo''o'"
~~~

### Integer

~~~
(int 1)
"1"
~~~

## Unary scalar operators

~~~
(uplus (int 1))
"+1"

(uminus (int 1))
"-1"

(not true)
"NOT TRUE"
~~~

## Binary scalar operators

~~~
(add (int 1) (int 1))
"1 + 1"
~~~

~~~
(sub (int 1) (int 1))
"1 - 1"
~~~

~~~
(div (int 1) (int 1))
"1 / 1"
~~~

~~~
(mul (int 1) (int 1))
"1 * 1"
~~~

## Binary boolean operators

~~~
(and left right)
"left AND right"
~~~

~~~
(or left right)
"left OR right"
~~~
