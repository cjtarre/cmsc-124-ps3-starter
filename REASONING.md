# Reasoning for the Predictions Table

Write one entry under every heading below, then commit this file together with
`predictions.tsv`, before you run a case or open `tests/expected.tsv`.

Each entry names the rule that produces the four predicted fields for that
case. One to three sentences is enough. The grader checks structure only. It
does not judge quality, and it sets no word minimum.

After you run the cases, add a short correction under each case you predicted
wrongly. Say what you predicted, what CLISP printed, and which rule you
misread. Those entries belong in the correction commits.

## P01
Case heads with the `+` **operator** which is a `function`, meaning it evaluates its arguments before executing. The inner `(* 2 3)` is also a function that evaluates to 6, and so the case evaluates this first and adds its result to 1, giving us the **value** `7` with **kind** `integer` and **length** `none` since it is an atom.

## P02
Case heads with the `'` **operator** which means `quote`, a `special-operator`. This special operator returns the argument untouched without any evaluation happening, giving us the **value** `(+,1,2)` with **kind** `cons` since it is a non-empty list and **length** `3` since it has three elements.

## P03
Case only has the atom `nil` so it's **operator** is `none`. This gives us **value** `nil` (it's written as-is) with **kind** `null` as prescribed by the course manual to avoid contradictions since in CLisp, it refuses to sit in a single box. It also has **length** `0` and not `none` since it technically is a sequence with no elements (empty).

## P04
Case only has `t`, the standard boolean symbol representing **truth**, so it's **operator** is `none` since it is atomic. This also gives us **value** `t`, **kind** `symbol`, and **length** `none` since again it is atomic.

## P05
Case has the atom `nil` but in `symbolp`. This gives us **operator** `none`, **value** `nil` (it's written as-is), and with **kind** `symbol` instead of the earlier `null` since it is in `symbolp`. It also has **length** `none` since it is an atom.

## P06
Case heads with the `car` **operator** which is a `function` that returns the first element of a list. However, the list is empty so `car` gives us the **value** `nil` with **kind** `null` (as prescribed by the course manual) and **length** `0` (not `none` since it technically is a list with no elements).

## P07
Case heads with `cons` which means its **operator** is a `function` and it evaluates its arguments before executing. The inner `'(2 3)` is also a `quote` function returns its argument untouched, and so the case evaluates this first and gives us the **value** `(1,(2,3))` with **kind** `cons` and **length** `2` since it has 2 elements, the second one being a 2-element list.

## P08
Case heads with `if`, which means its **operator** is a `special-operator`. This special operator evaluates its test condition first and then executes only one branch. The test form `(null '())` evaluates to `t` because `'()` evaluates to the empty list `nil`, and `(null '())` returns `t`. Because `t` represents truth (non-`nil`), `if` executes the then-branch, giving us the **value** `empty`, **kind** `string`, and **length** `none` since a string is an atom.

## P09
Case heads with `and` which means its **operator** is a `special-operator` that short-circuits once it encounters a `nil` value. Although the argument `1` is a non-nil value, the second argument is a `nil` so `and` short-circuits, leaving third argument `3` unevaluated. This gives us **value** `nil` (it's written as-is), **kind** `null` as prescribed by the course manual (see P03 for full explanation), and **length** `0` (not `none`) since it technically is a sequence with no elements (empty).

## P10
Case heads with `progn` which means its **operator** is a `special-operator` that evaluates forms in the order that they are given and only returns the result of the very last form. The final form temporarily binds the variable `ps3-rate` to `10` via `let` since the variable was declared with `defvar`, allowing for dynamic rebinding for the duration of that `let` body. Calling (ps3-scale 3) then gives us **value** `30` (from 3 * 10), **kind** `integer`, and **length** `none` since it is atomic.

## P11
Case heads with `defun` which means its **operator** is a `macro` used to define a function. Its return **value** is the function name `ps3-twice` which has **kind** `symbol` since evaluating this macro hands back the name of the function which is a symbol. Moreover, its **length** is `none` since it is atomic.

## P12
Case heads with `labels` which means its **operator** is a `special-operator` used to define a local function that can call itself recursively. The body calls `down(3)` which results to a `cons` (**kind**) with **value** `(3,2,1)` since the recursion decrements by 1 everytime it calls itself. The list also has a **length** `3`.

## P13
Case heads with `mapcar` which means its **operator** is a `function` that applies the function in its argument to every element of a list and collects the results of each one. `#'length` which pertains to function length (since `#'` is a shorthand for function) is applied over the list with three elements `(1 2) () (3)`, giving us **value** `(2,0,1)` with **kind** `cons` since the value is a non-empty list and **length** `3`.

## P14
Case heads with `mapcar` which means its **operator** is a `function` that applies the function in its argument to every element of a list and collects the results of each one. The lambda function with body `(* n n)` is applied over the list with three elements `'(1 2 3)`, giving us **value** `(2,0,1)` with **kind** `cons` since the value is a non-empty list and **length** `3`.

## P15
Case heads with `lambda`, which means its **operator** is a `macro`. Evaluating a `lambda` form creates an anonymous function object rather than executing its body, which the grader notation represents as `#<function>` (**value**) with **kind** `function` and **length** `none`.

## P16
Case heads with `let`, which means its **operator** is a `special-operator` that establishes local lexical bindings. The closure `f` created by `lambda` captures the lexical binding `factor = 2` from its defining environment, so when `(funcall f 3)` is evaluated inside an inner `let` where `factor` is rebound to `10`, `f` maintains `factor`'s value `2`. Evaluating, `(* 3 2)` give us the **value** `6` with **kind** `integer` and **length** `none`.
