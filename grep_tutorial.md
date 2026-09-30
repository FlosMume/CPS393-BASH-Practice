# `grep` Tutorial for WSL/Linux

## 1. Goal

`grep` is a text-filtering command. It reads text line by line, checks each line against a search pattern, and writes matching lines to standard output.

Basic form:

```bash
grep PATTERN FILE
```

Example:

```bash
grep Alice exercises/students.txt
```

---

## 2. Prepare the practice files

If you are using this repository, the files are already in `exercises/`.

Check them:

```bash
cat exercises/students.txt
cat exercises/words.txt
cat exercises/animals.txt
cat exercises/regex.txt
```

---

## 3. Basic matching

Run:

```bash
grep Alice exercises/students.txt
```

Try:

```bash
grep ComputerScience exercises/students.txt
```

Question: how many lines are printed?

`grep` prints the entire matching line, not only the matching word.

---

## 4. Read from standard input

Run:

```bash
grep Alice
```

Now type several lines manually:

```text
Alice is here
Bob is here
Alice studies CS
```

Press `Ctrl+D` when finished.

Why this works: with no filename, `grep` reads from standard input (`stdin`).

You can therefore also write:

```bash
grep Alice < exercises/students.txt
```

Compare it with:

```bash
grep Alice exercises/students.txt
```

The output is similar, but in the first case Bash connects the file to `grep`'s `stdin`.

---

## 5. Ignore case with `-i`

Run:

```bash
grep Bob exercises/students.txt
```

Then:

```bash
grep -i Bob exercises/students.txt
```

`-i` means ignore case.

Compare whether `Bob` and `bob` are both found.

---

## 6. Invert the match with `-v`

Run:

```bash
grep -v ComputerScience exercises/students.txt
```

`-v` means print lines that do **not** match the pattern.

Think of:

```text
grep PATTERN      -> keep matching lines
grep -v PATTERN   -> remove matching lines
```

Try:

```bash
grep -v Physics exercises/students.txt
```

---

## 7. Match the whole line with `-x`

Run:

```bash
grep abc exercises/words.txt
```

Then:

```bash
grep -x abc exercises/words.txt
```

`-x` requires the entire line to match.

---

# Regular Expressions

## 8. Important: globbing and `grep` regex are different

These two use different pattern systems:

```bash
ls *.txt
grep 'a.*b' file.txt
```

In shell globbing, `*` means an arbitrary sequence of characters.

In a regular expression used by `grep`, `*` means:

> zero or more repetitions of the previous item

This distinction is important.

---

## 9. `.` means one arbitrary character

Inspect:

```bash
cat exercises/animals.txt
```

Run:

```bash
grep 'd.g' exercises/animals.txt
```

The pattern means:

```text
d + any one character + g
```

Try to predict the matches before running it.

---

## 10. `^` means start of line

Run:

```bash
grep '^A' exercises/students.txt
```

This finds lines beginning with `A`.

Compare:

```bash
grep A exercises/students.txt
```

The second command allows `A` anywhere in the line.

---

## 11. `$` means end of line

Run:

```bash
grep 'Physics$' exercises/students.txt
```

Then:

```bash
grep 'ComputerScience$' exercises/students.txt
```

---

## 12. Combine `^` and `$`

Run:

```bash
grep '^abc$' exercises/words.txt
```

This means:

```text
start of line
abc
end of line
```

So the whole line must be exactly `abc`.

Compare with:

```bash
grep -x abc exercises/words.txt
```

---

## 13. Character sets with `[]`

Run:

```bash
grep '^[AB]' exercises/students.txt
```

This means the line starts with `A` or `B`.

Try:

```bash
grep '^[A-D]' exercises/students.txt
```

---

## 14. Negated character sets

Inside square brackets:

```text
[^A]
```

means one character that is not `A`.

Notice the two roles of `^`:

```text
^A       A must occur at the beginning of the line
[^A]     one character that is not A
```

---

## 15. `*` means zero or more of the previous item

Inspect:

```bash
cat exercises/regex.txt
```

Run:

```bash
grep 'su*m' exercises/regex.txt
```

Interpret it as:

```text
s
u*   -> zero or more u characters
m
```

It can therefore match:

```text
sm
sum
suum
suuum
```

Do not confuse this with shell glob `*`.

---

# Pipes and Redirection

## 16. Pipe command output into `grep`

Run:

```bash
ls | grep txt
```

Data flow:

```text
ls stdout -> pipe -> grep stdin -> terminal
```

Try:

```bash
ls | grep -v txt
```

---

## 17. Count matching lines

Combine `grep` and `wc`:

```bash
grep ComputerScience exercises/students.txt | wc -l
```

This illustrates the Unix idea of composing small tools:

```text
grep -> selects lines
wc   -> counts lines
|    -> connects them
```

---

## 18. Redirect matching lines into a file

Run:

```bash
grep ComputerScience exercises/students.txt > cs_students.txt
```

Check:

```bash
cat cs_students.txt
```

Then:

```bash
grep ComputerScience exercises/students.txt | wc -l > count.txt
cat count.txt
```

---

# Extended Regular Expressions

## 19. Use `grep -E`

`grep -E` enables extended regular expressions.

### OR with `|`

```bash
grep -E 'ComputerScience|Physics' exercises/students.txt
```

This means match either `ComputerScience` or `Physics`.

---

## 20. `+` means one or more

Run:

```bash
grep -E 'su+m' exercises/regex.txt
```

Compare:

```text
u*   zero or more
u+   one or more
```

So `sm` matches the first but not the second.

---

## 21. Repetition with `{m,n}`

Run:

```bash
grep -E 'u{2,3}' exercises/regex.txt
```

This looks for two or three consecutive `u` characters.

---

# Mixed Practice

Try these without looking at the answers first.

1. Find all ComputerScience students.
2. Find all students who are not in ComputerScience.
3. Find all lines whose first character is `A`.
4. Find all Physics students.
5. Find `Bob` or `bob` with one command.
6. Count ComputerScience students.
7. Save ComputerScience students to `cs.txt`.
8. Find ComputerScience or Physics students.
9. Count all lines that are not Physics.
10. Find lines ending in `ComputerScience`.

## Answers

```bash
grep ComputerScience exercises/students.txt

grep -v ComputerScience exercises/students.txt

grep '^A' exercises/students.txt

grep 'Physics$' exercises/students.txt

grep -i bob exercises/students.txt

grep ComputerScience exercises/students.txt | wc -l

grep ComputerScience exercises/students.txt > cs.txt

grep -E 'ComputerScience|Physics' exercises/students.txt

grep -v Physics exercises/students.txt | wc -l

grep 'ComputerScience$' exercises/students.txt
```

---

# Useful Documentation

Run:

```bash
man grep
```

Search inside the manual by typing:

```text
-i
```

or:

```text
-v
```

Press `n` for the next search result.

Press:

```text
q
```

to quit the manual.

Also useful:

```bash
grep --help
```

---

# What to Memorize

Memorize the concepts and common forms:

```text
grep PATTERN FILE

-i        ignore case
-v        invert match
-x        whole line

.         any one character
*         zero or more of previous item
^         start of line
$         end of line
[...]     character set
[^...]    negated character set

grep -E
|         OR
+         one or more
{m,n}     repetition
```

More importantly, understand these patterns:

```bash
command | grep PATTERN
grep PATTERN file | wc -l
grep PATTERN file > result.txt
```

You do not need to memorize every `grep` option. Use `man grep` for the long tail of details.
