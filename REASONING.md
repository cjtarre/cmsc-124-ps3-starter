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
Replace this line with the rule behind this case's four fields.

## P09
The case heads with `if`, which means its **operator** is a `special-operator`. This special operator evaluates its test condition first and then executes only one branch. The test form `(null '())` evaluates to `t` because `'()` evaluates to the empty list `nil`, and `(null '())` returns `t`. Because `t` represents truth (non-`nil`), `if` executes the then-branch, giving us the **value** `empty`, **kind** `string`, and **length** `none` since a string is an atom.

## P10
Replace this line with the rule behind this case's four fields.

## P11
Replace this line with the rule behind this case's four fields.

## P12
Replace this line with the rule behind this case's four fields.

## P13
Replace this line with the rule behind this case's four fields.

## P14
Replace this line with the rule behind this case's four fields.

## P15
Replace this line with the rule behind this case's four fields.

## P16
Replace this line with the rule behind this case's four fields.
