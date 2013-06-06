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

### Unary Scalars

~~~
(uplus 1)
"+(1)"

(uminus 1)
"-(1)"

(not true)
"!(TRUE)"
~~~
