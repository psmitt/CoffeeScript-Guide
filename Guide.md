# An Interactive Guide <br/> to CoffeeScript Universe

## Short Introduction to Everything

[CoffeeScript](http://coffeescript.org) is a programming language that compiles to JavaScript. JavaScript is based on the ECMAScript Language Specification ( [ECMA-262](https://www.ecma-international.org/ecma-262) ). The execution model of ECMAScript is implemented in [Node.js](https://nodejs.org) runtime system, built on Google Chrome's V8 JavaScript engine. [V8](https://developers.google.com/v8) compiles and executes JavaScript source code, handles memory allocation for objects, and garbage collects objects it no longer needs. V8 provides all the data types, operators, objects and functions specified in the ECMA-262 standard.

Depending on the host environment CoffeeScript can be used as a domain-specific scripting language for web browsers, or as a general-purpose programming language for various software platforms. The host environment of objects and facilities completes the capabilities of the scripting language.

This Guide follows the _learning by doing_ principle, using the methodology of exploratory programming for teaching the [elements of CoffeeScript language](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml) while discovering the runtime environment. The domain exploration is made possible by an interactive language shell running a read-eval-print loop ( [REPL](https://nodejs.org/api/repl.html) ). REPL takes single user inputs, evaluates them, and returns the result to the user.

### Have a Coffee

Install the current version of [Node.js](https://nodejs.org), then open a command line interface and install the newest version of CoffeeScript:

    os> npm install -g coffeescript

Enter the interactive CoffeeScript REPL by typing `coffee`. In order to exit REPL type `.exit`.

    os> coffee
    coffee> .exit
    os>

### Autocomplete

Pressing TAB displays an available name in the current scope starting with the already typed characters. In case of zero or multiple options no completion happens: pressing TAB for a second time will then display all of the autocomplete options.

Enter REPL, type `.` and press TAB twice to see the available commands for controlling the REPL session. Continue typing with `h` and press TAB once to have `.help` displayed. Press ENTER to see the result of `.help` command.

    os> coffee
    coffee> .
    break   clear   editor  exit    help    load    save

    coffee> .help
    .break    Sometimes you get stuck, this gets you out
    .clear    Alias for .break
    .editor   Enter editor mode
    .exit     Exit the REPL
    .help     Print this help message
    .load     Load code from a file into this REPL session
    .save     Save all evaluated commands in this REPL session to a file
    coffee>

The shortcut for `.break` is CTRL+C which can be pressed even if typing is not possible due to a stuck process. Pressing CTRL+C twice in an empty line is equivalent to `.exit`.

    coffee>
    (To exit, press ^C again or type .exit)
    coffee>

    os>

### Input Modes

REPL reads one or more input lines, evaluates the code, realizes side effects, and prints out the string representation of the value of the last expression in the input. Single-line input mode is the default: pressing ENTER makes the current line evaluated. Expressions within the line can be separated by semicolons.

    coffee> 11 ; 22 ;;; 33
    33

Multi-line input mode can be started by pressing CTRL+V. Then the prompt changes and pressing ENTER produces a simple line break. Similarly to semicolons, line breaks [terminate](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#T) expressions. Pressing CTRL+V again in the beginning of an empty line makes the previous lines evaluated and switches back to single-line input mode.

    ------> 11
    ....... 22
    ....... 33
    33
    coffee>

Another possibility to enter multiple lines is the editor mode of REPL activated by `.editor` command. The evaluation of the input happens on pressing CTRL+D, whilst CTRL+C interrupts editor mode without input evaluation.

#### Comments

In CoffeeScript, comments are denoted by the `#` character to the end of a line, or from `###` to the next appearance of `###`. This latter allows embedded or multiline comments as well.

    coffee> 11 # 22 ;;; 33 this is a line comment
    11
    coffee> 11 ### 22 this is a block comment ### ;;; 33
    33

## Literally Speaking

The evaluation of a valid input results a [literal value](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Literal). Literal is the ultimate output format: REPL does not transform literal values, literal values are _invariant_ to the evaluation loop. The _type_ of literals defines the [operations](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Operation) applicable on them. The type of expressions can be identified by the `typeof` operator. The result of the `typeof` operator is a string literal telling the name of the type.

### Undefined

The Undefined type has exactly one value called `undefined`. Any variable that has not been assigned a value has the value `undefined`.

    coffee> typeof anything
    'undefined'
    coffee> typeof undefined
    'undefined'

### Null

The Null type has exactly one value, called `null`, that represents the intentional absence of any object value.

    coffee> typeof null
    'object'

### Boolean

The [Boolean](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Boolean) type has exactly two values, representing a logical entity. However each values has three different literal forms in CoffeeScript.

    coffee> true is yes is on
    true
    coffee> false is no is off
    true
    coffee> typeof true
    'boolean'

Values of other types can be converted to Boolean by simply calling the `Boolean` function on them. The result of the conversion is `false` for arguments `undefined`, `null`, `false`, `+0`, `-0`, `NaN` or an empty string; otherwise it is `true`.

    coffee> Boolean ''
    false
    coffee> Boolean false
    false
    coffee> Boolean 'false'
    true

The [logical AND](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#AND) operator returns `false` in case its first operand expression converts to Boolean `false`; otherwise the value of the second operand expression is returned. The [logical OR](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#OR) operator returns the value of its first operand expression if the first expression converts to Boolean `true`; otherwise the value of the second operand expression is returned.

    coffee> false and true
    false
    coffee> 'false' and 'true'
    'true'
    coffee> false or true
    true
    coffee> 'false' or 'true'
    'false'

### Numbers

The [Number](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Number) type is the set of literals corresponding to a double-precision 64-bit binary format [IEEE 754-2008](https://standards.ieee.org/findstds/standard/754-2008.html) value. The evaluation of mathematical and logical expressions follows a well-defined operator precedence and associativity. Precedence rules can be overridden by [explicit parentheses](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Parenthetical).

Prefix, right-associative, [unary](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Unary) mathematical and logical operators have the highest precedence.

<table>
<tr><th>Operator</th><th>Meaning</th><th>Example</th><th>Result</th></tr>
<tr><td class="center"><code>+</code></td><td>conversion to number</td>
    <td class="center"><code>+true</code></td><td class="center"><code>1</code></td></tr>
<tr><td class="center"><code>-</code></td><td>mathematical negation</td>
    <td class="center"><code>-0</code></td><td class="center"><code>-0</code></td></tr>
<tr><td class="center"><code>~</code></td><td>bitwise complement</td>
    <td class="center"><code>~0</code></td><td class="center"><code>-1</code></td></tr>
<tr><td class="center"><code>!</code><br/><code>not</code></td><td>logical negation</td>
    <td class="center"><code>!true</code><br/><code>not true</code>
    </td><td class="center"><code>false</code><br/><code>false</code></td></tr>
</table>

The `**` exponentiation operator has the highest precedence among the binary matematical operators, and it is the only one being right-associative. 

<table>
<tr><th>Operator</th><th>Meaning</th><th>Example</th><th>Result</th></tr>
<tr><td class="center"><code>**</code></td><td>exponentiation ( <em>power</em> )</td>
    <td class="center"><code>2 ** 3</code></td><td class="center"><code>8</code></td></tr>
</table>

[Multiplicative](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Multiplicative) operators have the highest precedence among left-associative mathematical operators. [Additive](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Additive) operators have higher precedence than [bitwise shift](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Shift) operators. 

<table>
<tr class="bottom"><th>Operator</th><td><b>Meaning</b></td><td><b>Example<b/></td><td><b>Result<b/></td></tr>
<tr><td class="center"><code>*</code></td><td>multiplication</td>
    <td><code>7 * -3</code></td><td><code>-21</code></td></tr>
<tr><td class="center"><code>/</code></td><td>division</td>
    <td><code>7 / -3</code></td><td><code>-2.3333333333333335</code></td></tr>
<tr><td class="center"><code>%</code></td><td>JavaScript's modulo</td>
    <td><code>7 % -3</code></td><td><code>1</code></td></tr>
<tr><td class="center"><code>//</code></td><td>integer part ( <em>floor</em> ) of division</td>
    <td><code>7 // -3</code></td><td><code>-3</code></td></tr>
<tr class="bottom"><td class="center"><code>%%</code></td><td>remainder of <em>Euclidean</em> division</td>
    <td><code>7 %% -3</code></td><td><code>-2</code></td></tr>
<tr><td class="center"><code>+</code></td><td>addition</td>
    <td><code>7 + 3</code></td><td><code>10</code></td></tr>
<tr class="bottom"><td class="center"><code>-</code></td><td>substraction</td>
    <td><code>7 - 3</code></td><td><code>4</code></td></tr>
<tr><td class="center"><code>&lt;&lt;</code></td><td>bitwise left shift</td>
    <td><code>-100 &lt;&lt; 2</code></td><td><code>-400</code></td></tr>
<tr><td class="center"><code>&gt;&gt;</code></td><td>bitwise right shift</td>
    <td><code>-100 &gt;&gt; 2</code></td><td><code>-25</code></td></tr>
<tr><td class="center"><code>&gt;&gt;&gt;</code></td><td>bitwise unsigned right shift</td>
    <td><code>-100 &gt;&gt;&gt;&gt; 2</code></td><td><code>1073741799</code></td></tr>
</table>

Equality ( `==`, `is` ) and inequality ( `!=`, `isnt` ) operators in CoffeeScript are always _strict and type-safe_. Although they have lower precedence than other [relational operators](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Comparison), _chained comparison_ abolishes the precedence rule: the logical value of the chained comparison is true if and only if each binary relation is true.

    coffee> 2 >= 1 > +0 == -0 < 1 <= 2 != 3
    true

Each bitwise and logical operator has its own precedence in the following order.

<table>
<tr><th>Operator</th><th>Meaning</th><th>Example</th><th>Result</th></tr>
<tr class="bottom"><td class="center"><code>&amp;</code></td><td>bitwise conjunction</td>
    <td class="center"><code>51 &amp; 21</code></td><td class="center"><code>17</code></td></tr>
<tr class="bottom"><td class="center"><code>|</code></td><td>bitwise disjunction</td>
    <td class="center"><code>51 | 21</code></td><td class="center"><code>55</code></td></tr>
<tr class="bottom"><td class="center"><code>^</code></td><td>bitwise exclusion</td>
    <td class="center"><code>51 ^ 21</code></td><td class="center"><code>38</code></td></tr>
<tr class="bottom"><td class="center"><code>and</code><br/><code>&amp;&amp;</code></td><td>logical conjunction</td>
    <td class="center"><code>true and false</code></td><td class="center"><code>true</code></td></tr>
<tr class="bottom"><td class="center"><code>or</code><br/><code>||</code></td><td>logical disjunction</td>
    <td class="center"><code>true or false</code></td><td class="center"><code>false</code></td></tr>
</table>

#### Trinity

In additive operations zero means nothing. However in multiplicative operations zero is one of the three mightiest numbers: by multiplying, zero transforms numbers into its own image. Ordinary arithmetic does not allow division by zero, but CoffeeScript does: the result is another supernumber called `Infinity`. Both zero and `Infinity` can have positive or negative sign.

    coffee> 1 / 0
    Infinity
    coffee> 1 / -0
    -Infinity

`Infinity` has even more power over numbers than zero has: additive operations with `Infinity` result `Infinity`. It is interesting though what gives zero or `Infinity` divided by themselves, or what is their product. Each of these operations results `NaN`, the most powerful number among all. If `NaN` is an operand of an arithmetic expression, then the result is always `NaN`.

    coffee> 0 / 0
    NaN
    coffee> 0 * Infinity
    NaN
    coffee> typeof NaN
    'number'

`Infinity` is greater than any other numbers, except `NaN`, but not because `NaN` would be the greater one. `NaN` is simply uncomparable to anything, _it is even not equal to itself_ ! The other way to identify `NaN` value is the `isNaN` function.

    coffee> Infinity > NaN
    false
    coffee> Infinity <= NaN
    false
    coffee> NaN == NaN
    false
    coffee> NaN != NaN
    true
    coffee> isNaN NaN
    true

### Strings

[String](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#String) type is is the set of all ordered sequences of zero or more 16-bit unsigned integer values treated as UTF-16 encoded text data. [Unicode](http://www.unicode.org) code points may also be represented by an [escape sequence](http://www.ecma-international.org/ecma-262/#sec-literals-string-literals). Each character has a position in the string, the first being at index 0, assuming the string is not empty. The length of a string is the number of its 16-bit character elements within it. The empty string has length zero and therefore contains no elements.

Single-quoted strings are literal. <br/>
Double-quoted strings allow expression interpolation using `#{…}`.

    coffee> 'Literal string without #{ interpolation }'
    'Literal string without #{ interpolation }'
    coffee> "String with #{ Boolean( 1 + 1 ) } interpolation"
    'String with true interpolation'

In case of multiline strings indentation is ignored, and lines are joined by a single space unless they end with a backslash.

      ------> 'Beware
      .......         the
      .......             Jabberwock\
      .......             ,         \
      .......             my son!'
      'Beware the Jabberwock,         my son!'
      coffee>

Triple-quoted block strings can be used to hold formatted or indentation-sensitive text, however the minimal indentation level is maintained throughout the string block.

    ------> """
    .......       The jaws
    .......    that bite,
    .......       the claws,
    .......    that catch!
    ....... """
    '   The jaws\nthat bite,\n   the claws,\nthat catch!'
    coffee>

Strings can be concatenated by `+` operator.

    coffee> 'Hello' + ' ' + 'World!'
    'Hello World!'
    coffee> typeof ''
    'string'

### Symbols

The Symbol type is the set of all non-String values that may be used as the key of an Object property. Symbols do not have a literal syntax, the `Symbol` function is the only way to create them. `Symbol` is not a constructor function, no new objects can be created by that. `Symbol` can be given a string parameter which will be the key for the created Symbol; the default value for the key parameter is `'undefined'`.

    coffee> Symbol()
    Symbol()
    coffee> Symbol('key')
    Symbol(key)
    coffee> typeof Symbol('key')
    'symbol'
 
Each possible Symbol value is unique and immutable. Even symbols having the same key are different. However symbols created by the `Symbol.for` function get registered and are accessible globally, and therefore all references to them are identical. Keys used to create global symbols can be retrieved by the `Symbol.keyFor` function. Symbols are protected from any implicit conversion, however they can be explicitly converted to string by the `String` function or by the `toString` method.

    coffee> Symbol() is Symbol()
    false
    coffee> Symbol.for() is Symbol.for()
    true
    coffee> Symbol.keyFor Symbol 'key'
    undefined
    coffee> Symbol.keyFor Symbol.for()
    'undefined'
    coffee> Symbol.keyFor Symbol.for 'key'
    'key'
    coffee> String(Symbol()) is Symbol().toString()
    true

### Objects

An [Object](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Object) type is a collection of properties. Properties are identified and accessible using _key_ values. A property key is either a Symbol ( _id_ ), String ( _name_ ) or natural Number ( _index_ ).

An object literal is a list of name-value pairs wrapped in curly braces. Properties can be separated by commas, semicolons, and/or line breaks; keys and values must be separated by a colon. Object literals encapsulate data, creating a separate namespace for the properties. CoffeeScript does not allow Symbol keys in object literals; object properties with Symbol keys must be assigned separately.

Each object is a unique entity; object instances differ even when they have the same properties with the same values.

    ------> {
    .......  key : 'value of named property'
    .......  123 : 'value of indexed property'
    ....... }
    { '123': 'value of indexed property',
      key: 'value of named property' }
    coffee> typeof {}
    'object'
    coffee> {} is {}
    false

### Arrays

An [Array](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Array) object is a collection of values, identified and accessible via natural number indexes. The literal representation of arrays is the list of values in brackets, separated by commas, semicolons, and/or line breaks. Elisions are not allowed in CoffeeScript; use elisions in JavaScript literal instead.

    coffee> [ undefined; null; false; 0; ''; NaN ]
    [ undefined, null, false, 0, '', NaN ]
    coffee> typeof []
    'object'
    coffee> `[ 1,, 'Elision' ,, 2 ]` 
    [ 1, <1 empty item>, 'Elision', <1 empty item>, 2 ]

#### Ranges

A [range](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Range) is an array object of an increasing or decreasing sequence of numbers, where the difference between the consecutive elements is 1. The literal representation of a range is the range limits in brackets with two or three dots in between them.

The first element of the range is the value of the first expression in the brackets. The limit of the range is the value of the second expression. The sequence is increasing if the first element is less than the limit, otherwise it is decreasing. The sequence stops at the range limit. In case of two dots the limit is included in the range, if the limit is an element of the sequence. Otherwise the limit is excluded from the range.

    coffee> [1..5]
    [ 1, 2, 3, 4, 5 ]
    coffee> [2...-3]
    [ 2, 1, 0, -1, -2 ]
    coffee> [3/2..5]
    [ 1.5, 2.5, 3.5, 4.5 ]
    coffee> [1..5] instanceof Array
    true

#### Slices

Ranges used as index can slice strings and arrays. In order to properly index string characters or array elements, range must be a sequence of increasing natural numbers under the length of the string / array. Therefore the limits of the range are always truncated, and then transformed to the remainder of the Euclidean division by the lenght of the string / array. The result of slicing is the collection of string characters or array elements indexed by the elements of the transformed range. Range limits can be omitted: the default lower limit is zero, the default upper limit is the length of the string / array, excluded from the range.

    coffee> '0123456789'[3..6]
    '3456'
    coffee> '0123456789'[..-3]
    '01234567'
    coffee> '0123456789'[...-3]
    '0123456'
    coffee> '0123456789'[-3..]
    '789'

### Regular Expressions

A [RegExp](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#RegExp) object contains a text pattern used to match character combinations in strings. Based on the matches strings can be validated, modified or splitted. The literal format of a [regular expression](http://www.regular-expressions.info) is the search pattern specified between slashes. Searching options (flags) may be specified after the closing slash.

Similar to strings and comments, regular expressions do have a multiline block literal format that ignore internal whitespaces and can contain comments and interpolations. Regular expression blocks are delimited by triple slashes. 

    ------> /// ^
    ....... (?!.*(.).*\1)
    ....... [imguy]*
    ....... $ ///
    /^(?!.*(.).*\1)[imguy]*$/
    coffee> typeof /^(?!.*(.).*\1)[imguy]*$/
    'object'
    coffee> /^(?!.*(.).*\1)[imguy]*$/ instanceof RegExp
    true
    coffee> new RegExp
    /(?:)/

### Literal JavaScript

Literal JavaScript code can be embedded into CoffeeScript between backticks.

    coffee> `{[Symbol('foo')]: 'foo'}`
    { [Symbol(foo)]: 'foo' }
    coffee> `function say(something) { return something }`
    [Function: say]
    coffee> typeof say
    'function'
    coffee> say 'Hello!'
    'Hello!'

## Assignments

[Assigment](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Assignment) expressions make values stored in a retrievable way, or modify the content value of an already existing storage ( a.k.a. _compound assignment_ ). The storage name identifies the stored value in the current [scope](http://www.ecma-international.org/ecma-262/#sec-executable-code-and-execution-contexts). The identifier is called _property_ when the association between the name and the value is a part of an object. The identifier is called _variable_ when the association between the name and the value exists within an execution context ( e.g. in a function body ).

The indented block structure of an object description makes the braces and commas omittable. Even existing name and value associations can be reused for creation of new objects, but braces are required in this latter case to create the new scope.

    coffee> one = 1
    1
    coffee> two = 2
    2
    coffee> pair = { one, two }
    { one: 1, two: 2 }
    ------> pair =
    .......   three : 3
    .......   four : 4
    { three: 3, four: 4 }

Existing objects and arrays can be reused to create new ones. In order to include the properties of existing objects or the elements of existing arrays into a new one, splats `...` must be given before or after the name of the object or array. Usage of splats requires too the enclosing braces and brackets.

    ------> quad = {
    .......   two : 2
    .......   pair ... # three, four
    .......   five : 5
    ....... }
    { two: 2, three: 3, four: 4, five: 5 }
    coffee> triplet = [2..4]
    [ 2, 3, 4 ]
    coffee> array = [ 'one', triplet..., 'five']
    [ 'one', 2, 3, 4, 'five' ]

### Accessing Properties

New properties for existing objects can be easily created by assigning a value to the property name. This is the only way to create properties with Symbol keys. Symbol keys should be stored in the outer scope if the property must be accessible directly after the assignment. Existing ( and accessible ) properties of an object can be removed from the outer scope by `delete` operator.

    coffee> obj = new Object
    {}
    coffee> KEY = Symbol('key')
    Symbol(key)
    coffee> obj[KEY] = 'accessible value'
    'accessible value'
    coffee> obj[Symbol 'key'] = 'inaccessible value'
    'inaccessible value'
    coffee> obj.key = 'named value'
    'named value'
    coffee> obj[123] = 'indexed value'
    'indexed value'
    coffee> obj
    { '123': 'indexed value',
      key: 'named value',
      [Symbol(key)]: 'accessible value',
      [Symbol(key)]: 'inaccessible value' }
    coffee> delete obj[Symbol 'key']
    true
    coffee> obj
    { '123': 'indexed value',
      key: 'named value',
      [Symbol(key)]: 'accessible value',
      [Symbol(key)]: 'inaccessible value' }
    coffee> delete obj[KEY]
    true
    coffee> obj
    { '123': 'indexed value',
      key: 'named value',
      [Symbol(key)]: 'inaccessible value' }

Properties of an object can be hidden from enumeration by setting the `enumerable` attribute of their to `false`.
In order to enumerate non-inherited properties of an object, several helper functions exist.
- `Object.keys` function enumerates only the enumerable property names and indexes.
- `Object.getOwnPropertyNames` function enumerates all property names and indexes.
- `Object.getOwnPropertySymbols` function enumerates all symbol keys for properties.
- `Reflect.ownKeys` function enumerates all non-inherited properties of an object.

      coffee> Object.defineProperty obj, 123, { enumerable : false }
      { key: 'string key value', [Symbol(key)]: 'inaccessible value' }
      coffee> Object.keys obj
      [ 'key' ]
      coffee> Object.getOwnPropertyNames obj
      [ '123', 'key' ]
      coffee> Object.getOwnPropertySymbols obj
      [ Symbol(key) ]
      coffee> Reflect.ownKeys obj
      [ '123', 'key', Symbol(key) ]

In order to enumerate inherited properties use the above helper functions on the prototype chain of the object.

    coffee> obj.__proto__ is Object.getPrototypeOf obj
    true
    coffee> Object.getOwnPropertyNames obj.__proto__
    [ '__defineGetter__',
      '__defineSetter__',
      'hasOwnProperty',
      '__lookupGetter__',
      '__lookupSetter__',
      'propertyIsEnumerable',
      'toString',
      'valueOf',
      '__proto__',
      'constructor',
      'toLocaleString',
      'isPrototypeOf' ]
    coffee>

### Condition of Existence

The existential operator `?` serves to test if an identifier exists in the current context, i.e., its type and value are different from `undefined` or `null`. The behaviour of the operator depends on the test result, on the code context, and even on the space between the operator and the preceding expression.

<table>
<tr class="bottom"><td><b>Context</b></td><td><b>Behavior</b></td></tr>
<tr class="bottom"><td><code>e?</code></td>
    <td>tests if the value of expression <code>e</code> is different from <code>undefined</code> or <code>null</code></td></tr>
<tr class="bottom"><td><code>f? a</code></td>
    <td>calls function <code>f</code> with argument <code>a</code> if the function exists,
        <br/> otherwise returns <code>undefined</code></td></tr>
<tr class="bottom"><td><code>a ? b</code></td>
    <td>returns the value of expression <code>a</code> if different from <code>undefined</code> or <code>null</code>,
        <br/> otherwise returns the value of expression <code>a</code></td></tr>
<tr class="bottom"><td><code>o?.p</code><br/><code>o?['p']</code></td>
    <td>returns the property <code>p</code> of object <code>o</code> if the object exists
        <br/> otherwise returns <code>undefined</code></td></tr>
<tr class="bottom"><td><code>v ?= e</code></td>
    <td>assigns the value of expression <code>e</code> to the variable <code>v</code> if the variable is <code>null</code>,
        <br/> otherwise returns the original value of <code>v</code></td></tr>
</table>

### Destructuring Assignments

Destructuring assignment is an expression storing values exctacted from an object or array, into variables of the current scope. Identifiers on the left side have to be structured in the same way as the object or array on the right side in order to assign them the appropriate value. In case of object the identifiers must have the same name as the object's properties to match them. In case of array the assignments are based on the order of names and values.

    ------> object =
    .......   outer : 1
    .......   inner :
    .......     first : 10
    .......     second : 20
    .......
    { outer: 1, inner: { first: 10, second: 20 } }
    coffee> [ outer?, inner?, first?, second? ]
    [ false, false, false, false ]
    coffee> { inner : { first, second } } = object
    { outer: 1, inner: { first: 10, second: 20 } }
    coffee> [ outer?, inner?, first?, second? ]
    [ false, false, true, true ]
    coffee> swap = [ first, second ] = [ second, first ]
    [ 20, 10 ]
    coffee> [ nine, twenty, ten, five ] = [ 9, swap..., 5 ]
    [ 9, 20, 10, 5 ]
    coffee> ten is 10
    true

### Splicing Arrays

Splicing means to replace a segment of an array with new elements. In order to specify the segment to replace a slice of the array can be given on the left side of the assignment. The appropriate number of replacing elements should be given on the right side, in an array literal.

    coffee> numbers = [0..9]
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
    coffee> numbers[3..6] = [ 30, 40, 50, 60 ]
    [ 30, 40, 50, 60 ]
    coffee> numbers
    [ 0, 1, 2, 30, 40, 50, 60, 7, 8, 9 ]

## Functions

A [Function](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Function) object contains an executable code block ( a.k.a _function body_ ), which can receive runtime values to process, through an optional parameter list. The literal form of a function is called _anonymous function_ which can be assigned to a function name. The execution of a function is initiated by the invocation of the function name and enumeration of the argument expressions initializing the parameters.


The result of a function execution is the value of the last expression evaluated in the function body, or the value of the expression returned by a `return` statement. 

### Invocations ( a.k.a. Function Calls )

Argumentumok nélkül is lehet függényt hívni, ha utána írunk pl. egy kifejezést. Átadja ugyan a függvénynek, mint argumentumot, de az nem dolgozza fel.

#### Default Parameters

when argument is missing or undefined, but not when null!

#### Rest Parameters

...
variable number of arguments

#### Tagged Templates

A tagged template is a function call where the arguments of the call are derived from the postfix string with interpolations following the function name without spaces. The first argument is the array of text fragments between the interpolations, the following arguments are the values of the interpolated expressions.

    ------> decompose = (text, interpolations...) ->
    .......   { fragments : text, interpolations }
    [Function: decompose]
    coffee> decompose "One, #{ 2 }, three, #{ 4 }"
    { fragments: 'One, 2, three, 4', interpolations: [] }
    coffee> decompose"One, #{ 2 }, three, #{ 4 }"
    { fragments: [ 'One, ', ', three, ', '' ],
      interpolations: [ 2, 4 ] }

#### Chained Invocations

leading dot


#### Generator Functions

## Control Structures

### Conditional Expressions

[Conditional](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Conditional) expressions or statements have both prefix and postfix form; the latter is used for one-liners. The flow control is determined by either `if` or `unless` keywords to the true or false direction, respectively. Prefixed conditional blocks can be extended with `else` branches.

    coffee> if true then 'OK' else 'impossible'
    'OK'
    coffee> 'OK' unless false
    'OK'
    ------> if false
    .......   'It is false.'
    ....... else unless true
    .......   'It is still not true.'
    ....... else
    .......   'It is true.'
    'It is true.'

### Case Selections

[Switch](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Switch) flow control, based on possible values of an expression, is implementable by `switch` - `when` - `else` control structure. The blocks of the cases do not require `break` statement in the end in order to prevent fall-through; in fact, fall-through is not possible in CoffeeScript. It is valid to enumerated multiple options after `when`, separated by comma.

    coffee> month = 5
    5
    ------> switch month
    .......   when 1, 2, 12
    .......     'winter'
    .......   when 3, 4, 5
    .......     'spring'
    .......   when 6, 7, 8
    .......     'summer'
    .......   else
    .......     'autumn'
    'spring'

If the control expression after `switch` is omitted, the first case evaluated to `true` will be selected from the branch list.

    ------> switch
    .......   when month < 3 then 'winter'
    .......   when month < 6 then 'spring'
    .......   when month < 9 then 'summer'
    .......   when month < 12 then 'autumn'
    .......   else 'winter'
    'spring'

### Conditional Loops

[Loop](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Loop) conditions can be also specified in prefix or postfix position; the latter is used for one-liners. The flow control is determined by either `while` or `until` keywords repeating the loop body in true or false case, respectively. Loop condition can be extended with an additional `when` condition ( a.k.a _guard clause_ ) which controls the execution of the loop body for each iteration. Loops result the array of the values of the last expression of the loop body.

    coffee> n = 0
    0
    coffee> while ++n < 10 when n % 2 then n
    [ 1, 3, 5, 7, 9 ]
    coffee> n until --n is 0 when n % 3
    [ 8, 7, 5, 4, 2, 1 ]

Loops counting from and to a given value with fixed-size increments, or iterating over the keys and values of an object or array, can be implemented in a clear and comprehensible way using different forms of `for` loops. In order to iterate over numbers, the most suitable form is to use range comprehensions. Without loop parameter the range comprehension simply counts the number of iterations; the `by` stepping size is a way to influence the counter. [For loops](http://rawgit.com/psmitt/metalanguage/master/examples/CoffeeScript.xml#Loop) can also have an optional guard clause.

    coffee> n = 0
    0
    coffee> n += 1 for [1...10] by 2
    [ 1, 2, 3, 4, 5 ]
    coffee> for n in [1...10] by 2 then n
    [ 1, 3, 5, 7, 9 ]
    coffee> n for n in [9..1] when n % 3
    [ 8, 7, 5, 4, 2, 1 ]

When iterating over an array with `for` - `in` syntax, the first parameter after `for` takes the value of the current array element; the optional second parameter can take the index of it. The order is the opposite with `for` - `of` syntax which is use to iterate over objects: here the first parameter is the key, the optional second is the value of the current property. The `by` stepping size cannot be specified for the iterations over objects.

    coffee> numbers = [ 'two', 'six', 'ten' ]
    [ 'two', 'six', 'ten' ]
    coffee> "#{ index }. #{ value }" for value, index in numbers
    [ '0. two', '1. six', '2. ten' ]
    coffee> "#{ index }. #{ value }" for index, value of numbers
    [ '0. two', '1. six', '2. ten' ]
    ------> numbers =
    .......   two : 2
    .......   six : 6
    .......   ten : 10
    { two: 2, six: 6, ten: 10 }
    coffee> "#{ key } = #{ value }" for key, value of numbers
    [ 'two = 2', 'six = 6', 'ten = 10' ]

In order to iterate only over non-inherited properties of an object, the `for own` - `of` syntax may be used.

In order to iterate a generator function

### Unconditional Loops


  
## Objects All Around

Exit and enter REPL for a fresh start. REPL's lexical environment is a _global environment_, prepopulated with identifier bindings, and includes an associated _global object_ whose properties provide some of the global environment's identifier bindings.

Use the autocomplete function of REPL to discover existing entities. List all available identifiers in the current namespace by a double TAB in an empty line. Get the same list by pressing TAB twice after `global.` or `this.`, printing the properties of the global object. The global object inherits some properties from `Object`, the rests are its own properties. Display the inherited properties by a double TAB after `Object.prototype.`, then list the global object's own properties by calling `Object.getOwnPropertyNames global`.

Obsolete references to the global objects could still exist in the global environment for compatibility purposes.

    coffee> this is global is GLOBAL is root
    true
    [DEP0016] DeprecationWarning: 'GLOBAL' is deprecated, use 'global'
    [DEP0016] DeprecationWarning: 'root' is deprecated, use 'global'

### Origin

The `Object` constructor function is the initial value of the `Object` property of the global object. When called as a constructor it creates a new ordinary object. When `Object` is called as a function rather than as a constructor, it performs a type conversion.

    coffee> typeof Object
    'function'
    coffee> typeof new Object
    'object'
    coffee> typeof Object()
    'object'

The real immutable primary intrinsic object of the CoffeeScript Universe is the `Object.prototype`. Use double TAB to see its properties.

    coffee> Object.prototype.
    Object.prototype.__defineGetter__      Object.prototype.__defineSetter__
    Object.prototype.__lookupGetter__      Object.prototype.__lookupSetter__
    Object.prototype.__proto__             Object.prototype.constructor
    Object.prototype.hasOwnProperty        Object.prototype.isPrototypeOf
    Object.prototype.propertyIsEnumerable  Object.prototype.toLocaleString
    Object.prototype.toString              Object.prototype.valueOf

When `Object` function is called with a boolean, number, or string literal value, it results a _wrapper object_ of the argument. `Boolean`, `Number`, and `String` wrapper objects are own properties of the global object, providing useful transformation and validation methods. Examine the own properties of the wrapper object by `Object.getOwnPropertyNames` function.



