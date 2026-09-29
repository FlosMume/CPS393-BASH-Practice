# Shell Globbing in Bash

## 1. What globbing is

Globbing is filename pattern expansion performed by the shell.

When Bash sees a glob pattern, it normally:

1. expands the pattern into matching filenames;
2. executes the resulting command.

This means `ls` usually does not interpret `*.txt`; Bash expands it first.

---

## 2. Prepare a practice directory

```bash
mkdir -p ~/cps393/glob_practice
cd ~/cps393/glob_practice
touch lab1.txt lab2.txt lab3.txt lab4.txt
touch lab4.cpp lb2.txt new.txt
touch prog1.c prog2.c pie.c top.c
touch A Ax Axxx Axxxx Ay X x X.bak xx xxxx
```

Check:

```bash
ls
```

---

## 3. `?` — exactly one character

```bash
ls lab?.txt
```

`?` matches exactly one character.

Try:

```bash
ls lab?.???
```

Predict the result before running it.

---

## 4. `*` — any sequence of characters

```bash
ls *.txt
```

`*` can match zero or more characters.

Try:

```bash
ls lab*
ls *.c
ls A*
```

---

## 5. `[]` — character sets

```bash
ls lab[1-3].txt
```

Try:

```bash
ls [A-Z]*
ls [!A]*
```

Inside a bracket expression, `!` can negate the set.

Examples:

```text
[ABC]    one character: A, B, or C
[A-Z]    one uppercase letter
[!ABC]   one character except A, B, or C
[!0-9]   one non-digit character
```

---

## 6. What if nothing matches?

Try:

```bash
ls zzz*.txt
```

In the normal Bash configuration used in many teaching examples, if the glob has no match, the pattern remains unchanged and is passed to the command.

You may then see an error from `ls` for the literal name `zzz*.txt`.

---

## 7. Quoting prevents glob expansion

Compare:

```bash
echo *.txt
```

with:

```bash
echo "*.txt"
```

and:

```bash
echo '*.txt'
```

The quoted forms preserve the literal `*`.

You can also escape an individual special character:

```bash
echo \*.txt
```

---

## 8. Globbing versus regular expressions

Do not confuse:

```bash
ls *.txt
```

with:

```bash
grep 'a.*b' file.txt
```

In a shell glob:

```text
* = arbitrary sequence of characters
? = one arbitrary character
```

In a regular expression used by `grep`:

```text
. = one arbitrary character
* = zero or more of the preceding item
```

The shell interprets the glob; `grep` interprets the regex.

---

## 9. Extended globbing

Bash supports extended patterns such as:

```text
?(pattern)        zero or one occurrence
*(pattern)        zero or more occurrences
+(pattern)        one or more occurrences
@(p1|p2)          one of the alternatives
!(pattern)        anything except the pattern
```

Extended globbing may need to be enabled:

```bash
shopt extglob
shopt -s extglob
```

Now try:

```bash
ls @(*xx|*ak)
```

With the sample files, this matches names ending in `xx` or `ak`.

Then try:

```bash
ls !(@(*xx|*ak))
```

This selects names that do not match that combined pattern.

---

## 10. Important mental model

When you type:

```bash
ls *.txt
```

think:

```text
typed command
    |
    v
Bash expands *.txt
    |
    v
ls file1.txt file2.txt ...
```

That is why quoting matters.

---

## Practice

1. Match all `.txt` files.
2. Match files named `lab` + exactly one character + `.txt`.
3. Match files beginning with `prog`.
4. Match names beginning with an uppercase letter.
5. Match names whose first character is not `A`.
6. Print the literal string `*.txt` without expansion.
7. Enable `extglob`.
8. Match names ending in `xx` or `ak`.
9. Match everything except names ending in `xx` or `ak`.

## Core memory

```text
?       one character
*       zero or more characters
[...]   one character from a set/range
[!...]  one character not in a set
quotes  suppress glob expansion
```
