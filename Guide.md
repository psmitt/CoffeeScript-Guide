# An Interactive Guide <br/> to CoffeeScript Universe

## Short Introduction to Everything

[CoffeeScript](http://coffeescript.org/v2) is a programming language that compiles to JavaScript. JavaScript is based on the ECMAScript Language Specification (  [ECMA-262](https://www.ecma-international.org/ecma-262) ). The execution model of ECMAScript is implemented in [Node.js](https://nodejs.org) JavaScript runtime system, built on Google Chrome's V8 JavaScript engine. [V8](https://developers.google.com/v8) compiles and executes JavaScript source code, handles memory allocation for objects, and garbage collects objects it no longer needs. V8 provides all the data types, operators, objects and functions specified in the ECMA-262 standard.

Depending on the host environment CoffeeScript can be used as a domain-specific scripting language for web browsers, or as a general-purpose programming language for various software platforms. The host environment of objects and facilities completes the capabilities of the scripting language.

This Guide follows the _learning by doing_ principle, using the methodology of exploratory programming for teaching the elements of CoffeeScript language while discovering the runtime environment. The domain exploration is made possible by an interactive language shell running a read-eval-print loop ( [REPL](https://nodejs.org/api/repl.html) ). REPL takes single user inputs, evaluates them, and returns the result to the user.

## Let Us Have Coffee

Install the current version of [Node.js](https://nodejs.org), then open a command line interface and install the newest version of CoffeeScript:

    os> npm install -g coffeescript@next

Enter the interactive CoffeeScript REPL by typing `coffee`. In order to exit REPL type `.exit`.

    os> coffee
    coffee> .exit
    os>

### Autocomplete

Pressing TAB displays an available name in the current scope, starting with the already typed characters. In case of zero or multiple options no completion happens: pressing TAB for a second time will then display all of the autocomplete options.

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

## Do the Math

An unsurprising capability of CoffeeScript is the support of calculations. Using the well-known [arithmetic](https://standards.ieee.org/findstds/standard/754-2008.html) operators in the formulas, the result is immediately displayed by pressing ENTER at the end of the line. The last result, represented by the underscore character, is always reusable in the subsequent calculation.

    coffee> -1 + 2 * 3 / 4
    0.5
    coffee> _ + 6 * 7 / 8
    5.75

Beyond the usual arithmetic operators, CoffeeScript provides some specific binary multiplicative operators for integer calculations, e.g. the standard mathematical `%%` [modulo operator](https://en.wikipedia.org/wiki/Modulo_operation) which is different from the default `%` modulo operator of the JavaScript language:

<table style="margin:auto">
<tr><th>Operator</th><th>Meaning</th><th>Example</th><th>Result</th></tr>
<tr><td style="text-align:center"><code> ** </code></td><td>exponentiation ( <em>power</em> )</td><td style="text-align:right"><code>2 ** 3</code></td><td><code>== 8</code></td></tr>
<tr><td style="text-align:center"><code> // </code></td><td>integer part ( <em>floor</em> ) of division</td><td style="text-align:right"><code>22 // 7</code></td><td><code>== 3</code></td></tr>
<tr><td style="text-align:center"><code> %% </code></td><td>remainder of <em>Euclidean</em> division &nbsp; &nbsp;</td><td style="text-align:right"><code>-5 %% 3</code></td><td><code>== 1</code></td></tr>
<tr><td style="text-align:center"><code> % </code></td><td>JavaScript's modulo</td><td style="text-align:right"><code>-5 % 3</code></td><td><code>== -2</code></td></tr>
</table>

Arithmetic operators can be applied to any number though, not just to integers.

_Chained comparison_ is an impressive feature of the language: consecutive arithmetic relations of the same expression can be connected into one single expression. The logical value of the chained comparison is true if and only if each binary relation is true.

    coffee> 2 >= 1 > +0 == -0 < 1 <= 2 != 3
    true

#### Trinity

In additive operations zero means nothing. However in multiplicative operations zero is one of the three mightiest numbers: by multiplying, zero transforms numbers into its own image. Ordinary arithmetic does not allow division by zero, but CoffeeScript does: the result is another supernumber called `Infinity`. Both zero and `Infinity` can have positive or negative sign.

    coffee> 1 / 0
    Infinity
    coffee> 1 / -0
    -Infinity

`Infinity` has even more power over numbers than zero has: additive operations with `Infinity` result `Infinity`. It is interesting though what gives zero or `Infinity` divided by themselves, or what is their product. Each of these operations result `NaN`, the most powerful number among all. If `NaN` is an operand of an arithmetic expression, then the result is always `NaN`.

    coffee> 0 / 0
    NaN
    coffee> 0 * Infinity
    NaN

Take an operation, e.g. _division_. In order to show what does this operation result with different kind of numbers, collect the most interesting numbers into an array, and then apply the operation onto every pair of them.

    coffee> numbers = [ -1, 0, Infinity, NaN ]
    [ -1, 0, Infinity, NaN ]
    coffee> for one in numbers then for another in numbers then one / another
    [ [ 1, -Infinity, -0, NaN ],
      [ -0, NaN, 0, NaN ],
      [ -Infinity, Infinity, NaN, NaN ],
      [ NaN, NaN, NaN, NaN ] ]

`Infinity` is greater than any other numbers, except `NaN`, but not because `NaN` would be the greater one. `NaN` is simply uncomparable to anything, _it is even not equal to itself_ ! The other way to identify `NaN` value is the `isNaN` function.

    coffee> Infinity > NaN
    false
    coffee> Infinity <= NaN
    false
    coffee> NaN is NaN
    false
    coffee> NaN isnt NaN
    true
    coffee> isNaN( NaN )
    true

## From Type to Type

The name of `NaN` is the abbreviation of _Not-a-Number_, however __it is a number__ according to its _type_. The type of expressions can be examined by `typeof` operator.

    coffee> typeof NaN
    'number'

The result of `typeof` is a string telling the name of the type.

    coffee> typeof typeof NaN
    'string'

### Primitive Types

_Primitive_ or _non-Object_ types represent a definite set of values. The already mentioned Number type is one among them: a Number value is a primitive value corresponding to a double-precision 64-bit binary format IEEE 754-2008 value.

The Undefined type has exactly one value called `undefined`. Any variable that has not been assigned a value has the value `undefined`.

    coffee> typeof anything
    'undefined'
    coffee> typeof undefined
    'undefined'

The Boolean type represents a logical entity having two values, called `true` and `false`. Boolean values can also be referenced in CoffeeScript as `yes` and `no`, or `on` and `off`, respectively. CoffeeScript provides relational operators `is` and `isnt` for type-safe value comparison purposes.

    coffee> true is yes is on
    true
    coffee> false is no is off
    true

Values of other types can be converted to Boolean by simply calling the Boolean function on them. The result of the conversion is `false` for arguments `undefined`, `null`, `false`, `+0`, `-0`, `NaN` or an empty string; otherwise it is `true`.

    coffee> Boolean('')
    false
    coffee> Boolean(false)
    false
    coffee> Boolean('false')
    true

The logical `and` operator returns `false` in case its first operand expression converts to Boolean `false`; otherwise the value of the second operand expression is returned. The logical `or` operator returns the value of its first operand expression if the first expression converts to Boolean `true`; otherwise the value of the second operand expression is returned.

    coffee> false and true
    false
    coffee> 'false' and 'true'
    'true'
    coffee> false or true
    true
    coffee> 'false' or 'true'
    'false'

#### Play with Strings

String type is is the set of all ordered sequences of zero or more 16-bit unsigned integer values treated as UTF-16 encoded text data. Each Unicode character has a position in the string, the first being at index 0, assuming the string is not empty. The length of a string is the number of its 16-bit character elements within it. The empty string has length zero and therefore contains no elements.

Single-quoted strings are literal. Double-quoted strings allow expression interpolation using `#{ … }`.

    coffee> 'Literal string without #{ interpolation }'
    'Literal string without #{ interpolation }'
    coffee> "String with #{ Boolean( 1 + 1 ) } interpolation"
    'String with true interpolation'

In case of multiline strings indentation is ignored, and lines are joined by a single space unless they end with a backslash. In order to type multiple line input, REPL provides two ways for line wrapping:

- CTRL+V starts multi-line input mode. The evaluation of inputted lines happens
  by another CTRL+V, switching back to single-line mode.

      ------> 'Beware
      .......         the
      .......             Jabberwock\
      .......             ,         \
      .......             my son!'
      'Beware the Jabberwock,         my son!'
      coffee>

- `.editor` command activates editor mode, allowing free text edition.
  The evaluation of the input starts by CTRL+D, whilst CTRL+C interrupts editor
  mode without input evaluation.

      coffee> .editor
      // Entering editor mode (^D to finish, ^C to cancel)
      'Beware
              the
                  Jabberwock\
                  ,         \
                  my son!'
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

### Object types

An Object type is a collection of properties. Properties are identified and accessible using _key_ values. A property key is either a unique Symbol ( _id_ ), String ( _name_ ) or natural Number ( _index_ ). Instances of an Object type have their own property values for each of their properties.

    coffee> obj = new Object()
    {}
    coffee> obj.SymbolKey = 'value of SymbolKey property'
    'value of SymbolKey property'
    coffee> obj["String key"] = 'value of "String key" property'
    'value of "String key" property'
    coffee> obj[12345] = 'value of 12345 property'
    'value of 12345 property'
    coffee> obj
    { '12345': 'value of 12345 property',
      SymbolKey: 'value of SymbolKey property',
      'String key': 'value of "String key" property' }
    coffee>
