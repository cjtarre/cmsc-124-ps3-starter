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

The literal `1` is evaluated before the nested `*` expression, which produces 6. The outer `+` function adds the two values to produce 7, an integer with no sequence length.

## P02

`quote` returns the form `(+ 1 2)` without evaluating it. The result is therefore a three-element cons list, and `quote` is a special operator.

## P03

`nil` evaluates to the empty list. Under the course vocabulary, it has kind `null`, has length 0, and has no operator because the form is atomic.

## P04

`t` evaluates to the symbol `t`. It is a non-`nil` symbol with no sequence length and no operator because it is atomic.

## P05

`symbolp` tests whether `nil` is a symbol and returns `t`. The result is a symbol with no sequence length, and `symbolp` is a function.

## P06

`car` of the empty list returns `nil`. Thus, the value has kind `null` and length 0, while `car` is a function.

## P07

`cons` adds 1 to the front of `(2 3)`, producing `(1 2 3)`. The result is a cons list of length 3, and `cons` is a function.

## P08

`null` returns true for the empty list, so `if` evaluates its true branch and returns the symbol `empty`. The result has no sequence length, and `if` is a special operator because it controls which branch is evaluated.

## P09

`and` stops when it reaches `nil`, so the final value is `nil`, which has kind `null` and length 0. In the CLISP classification used by this problem set, `and` is recorded as a special operator.

## P10

`defvar` makes `*ps3-rate*` a special variable. The `let` dynamically binds it to 10 while `ps3-scale` runs, so multiplying 3 by the current rate produces 30, an integer with no sequence length; the outer `progn` is a special operator.

## P11

`defun` defines `ps3-twice` and returns its function name, the symbol `ps3-twice`. The returned symbol has no sequence length, and `defun` is classified as a macro.

## P12

`labels` creates the recursive local function `down`, which adds each positive number to a list until `n` reaches zero. Calling it with 3 constructs `(3 2 1)`, a cons list of length 3, and `labels` is a special operator.

## P13

`mapcar` applies `length` to each list, producing lengths 2, 0, and 1. The result is `(2 0 1)`, a cons list of length 3, and `mapcar` is a function.

## P14

`mapcar` applies the lambda to 1, 2, and 3, squaring each number. This produces `(1 4 9)`, a cons list of length 3, while `mapcar` is a function.

## P15

Evaluating a lambda expression produces a function object rather than running its body. Its kind is therefore `function`, it has no sequence length, and `lambda` is classified as a macro for this table.

## P16

The lambda closes over the outer lexical binding where `factor` is 2. The later binding of `factor` to 10 does not replace the captured binding, so `(funcall f 3)` produces 6, an integer with no sequence length; the outer `let` is a special operator.
