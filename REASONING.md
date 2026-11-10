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
The case heads with the `+` operator, which is a **function** that evaluates its arguments before performing addition. The literal `1` is evaluated first, followed by the nested `(* 2 3)` expression, which produces `6`. Adding both results gives the value **7** with kind **integer** and length **none** since integers are not sequences.

## P02
The case heads with the `quote` operator, written as `'`, which is a **special-operator** that returns its argument without evaluating it. This produces the value **(+,1,2)** with kind **cons** since it is a non-empty list and length **3** because it contains three elements.

## P03
The case contains only the atom `nil`, so its operator is **none**. It evaluates to the value **nil** with kind **null** (as prescribed by the course manual), since Common Lisp treats `nil` as the empty list, a symbol, and false. Its length is **0** rather than none because `nil` also represents the empty list, which is a sequence with no elements.

## P04
The case contains only `t`, the standard symbol representing truth, so its operator is **none** since the form is atomic. This gives the value **t** with kind **symbol** and length **none** because it is not a sequence.

## P05
The case contains the atom `nil` but heads with `symbolp`, which tests whether `nil` is a symbol and returns `t`. The result is the value **t** with kind **symbol** and length **none** since it is not a sequence, and `symbolp` is a **function** operator.

## P06
The case heads with the `car` operator, which is a **function** that returns the first element of a list. However, since the quoted list is empty, `car` returns the value **nil** with kind **null** and length **0** rather than none, since `nil` also represents the empty list, which is a sequence with no elements.

## P07
The case heads with `cons`, a **function** operator that adds 1 to the front of `(2,3)` to produce the value **(1,2,3)** with kind **cons** and length **3**.

## P08
The case heads with the `if` operator, a **special-operator** that controls which branch is evaluated. It first evaluates `null`, which returns true for the empty list, and then evaluates its true branch and returns the value **empty** with kind **symbol**. Its length is **none** because it is not a sequence.

## P09
The case heads with the `and` operator, which is classified as a **special-operator** under the CLISP rules used in this problem set. Although the first argument `1` is non-`nil`, the second argument evaluates to `nil`, causing `and` to short-circuit without evaluating the third argument. This produces the value **nil** with kind **null** and length **0** because it represents the empty list.

## P10
The case heads with the `progn` operator, which is a **special-operator** that evaluates its forms in sequence and returns the result of the last form. Since `defvar` declares `ps3-rate` as a special variable, the inner `let` dynamically binds it to `10` while `ps3-scale` executes. Multiplying `3` by the current rate produces the value **30** with kind **integer** and length **none** because integers are not sequences.

## P11
The case heads with the `defun` operator, which is classified as a **macro** used to define a function. Evaluating the form returns the function name, giving the value **ps3-twice** with kind **symbol** and length **none** because the returned symbol is not a sequence.

## P12
The case heads with the `labels` operator, which is a **special-operator** that defines local functions capable of recursive calls. The function `down` starts at `3`, adds each positive number to the list, and stops when `n` reaches zero and returns the empty list. This produces the value **(3,2,1)** with kind **cons** and length **3**.

## P13
The case heads with the `mapcar` operator, which is a **function** that applies another function to each element of a list and collects the results. The expression `#'length` refers to the `length` function, which is applied to `(1 2)`, `()`, and `(3)`, producing the value **(2,0,1)** with kind **cons** and length **3**.

## P14
The case heads with the `mapcar` operator, which is a **function** that applies the given function to every element of a list. The lambda expression `(* n n)` squares each element of `'(1 2 3)`, producing the value **(1,4,9)** with kind **cons** and length **3** because the result is a non-empty list containing three elements.

## P15
The case heads with the `lambda` operator, which is classified as a **macro** under the course rules. Evaluating the lambda expression creates an anonymous function object rather than executing its body, producing the value **#<function\>** with kind **function** and length **none** because a function object is not a sequence.

## P16
The case heads with the `let` operator, a **special-operator** that establishes local lexical bindings. The lambda closes over the outer lexical binding where `factor` is `2`, so when `(funcall f 3)` is evaluated inside an inner let that rebinds `factor` to `10`, the later binding does not replace the captured one, producing the value **6** with kind **integer** and length **none** since an integer has no sequence length.
