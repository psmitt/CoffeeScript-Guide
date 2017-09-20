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

### Number

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
<tr><th>Operator</th><th>Meaning</th><th>Example</th><th>Result</th></tr>
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

### String

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

### Symbol

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

### Object

An Object type is a collection of properties. Properties are identified and accessible using _key_ values. A property key is either a Symbol ( _id_ ), String ( _name_ ) or natural Number ( _index_ ). String and Number property keys can be listed by `Object.getOwnPropertyNames` function; Symbol property keys can be listed by `Object.getOwnPropertySymbols` function.

    coffee> object = new Object
    {}
    coffee> object[Symbol 'key'] = 'value of property having Symbol key'
    'value of property having Symbol key'
    coffee> object[String 'key'] = 'value of property having String key'
    'value of property having String key'
    coffee> object[Number 'key'] = 'value of property having Number key'
    'value of property having Number key'
    coffee> object
    { key: 'value of property having String key',
      NaN: 'value of property having Number key',
      [Symbol(key)]: 'value of property having Symbol key' }
    coffee>Object.getOwnPropertyNames object
    [ 'key', 'NaN' ]
    coffee>Object.getOwnPropertySymbols object
    [ Symbol(key) ]

Objects have literal representation, where properties are listed in braces, separated by commas and/or line breaks. Each listed property is identified by its key and value, separated by a colon.

### Array

An Array objects is a collection of values, identified and accessible via natural number indexes. The literal representation of arrays is the list of values in brackets, separated by commas and/or line breaks.

    coffee> array = new Array
    []
    coffee> array[1] = 'one' ; array[2] = 'two' ; array[5] = 'five'
    'five'
    coffee> array.length
    6
    coffee> array
    [ <1 empty item>, 'one', 'two', <2 empty items>, 'five' ]
    coffee> array.sort()
    [ 'five', 'one', 'two', <3 empty items> ]

### Regular Expression

A RegExp object contains a text pattern used to match character combinations in strings. Based on the matches strings can be validated, modified or splitted. The literal format of a [regular expression](http://www.regular-expressions.info) is the search pattern specified between slashes. Searching options (flags) may be specified after the closing slash.

    coffee> re = new RegExp
    /(?:)/
    coffee> re.test 'anything'
    true

### Literal JavaScript

Literal JavaScript code can be embedded into CoffeeScript between backticks.

    coffee> say = `function (something) { return something }`
    [Function: say]
    coffee> typeof say
    'function'
    coffee> say 'Hello!'
    'Hello!'

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



