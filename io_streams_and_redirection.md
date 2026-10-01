# I/O Streams and Redirection in Linux

## 1. The three standard streams

Every command normally has three standard streams:

```text
stdin   = standard input   = file descriptor 0
stdout  = standard output  = file descriptor 1
stderr  = standard error   = file descriptor 2
```

Typical defaults:

```text
keyboard -> stdin -> command -> stdout -> terminal
                         \
                          -> stderr -> terminal
```

Try:

```bash
cat
```

Type a few lines, then press `Ctrl+D` to send EOF.

---

## 2. Redirect stdout

```bash
ls > files.txt
cat files.txt
```

`>` overwrites or creates the destination file.

Try append:

```bash
echo "another line" >> files.txt
cat files.txt
```

`>>` appends.

---

## 3. Redirect stdin

Create a file:

```bash
printf "one two three\nfour five\n" > sample.txt
```

Now compare:

```bash
wc sample.txt
wc < sample.txt
```

The first passes the filename as an argument to `wc`.
The second connects `sample.txt` to `wc`'s `stdin`.

---

## 4. Redirect input and output together

```bash
wc < sample.txt > count.txt
cat count.txt
```

Data flow:

```text
sample.txt -> stdin -> wc -> stdout -> count.txt
```

---

## 5. Redirect stderr

Generate an error:

```bash
ls does_not_exist
```

Now redirect only the error stream:

```bash
ls does_not_exist 2> error.txt
cat error.txt
```

Remember:

```text
0 = stdin
1 = stdout
2 = stderr
```

So these are equivalent:

```bash
ls > out.txt
ls 1> out.txt
```

and:

```bash
cat < sample.txt
cat 0< sample.txt
```

---

## 6. Redirect stdout and stderr separately

```bash
ls sample.txt does_not_exist > normal.txt 2> errors.txt
```

Inspect:

```bash
cat normal.txt
cat errors.txt
```

---

## 7. Redirect both stdout and stderr

In Bash:

```bash
ls sample.txt does_not_exist &> all.txt
cat all.txt
```

---

## 8. `/dev` and special files

Linux exposes many devices and special endpoints through `/dev`.

Inspect:

```bash
ls -l /dev/stdin /dev/stdout /dev/stderr /dev/null
```

Try:

```bash
echo "hello stdout" > /dev/stdout
echo "hello stderr" > /dev/stderr
```

Discard output:

```bash
echo "you will not see this" > /dev/null
```

A practical example:

```bash
find /usr -name something 2>/dev/null
```

The permission-error messages are sent to `/dev/null`.

---

## 9. Pipes

A pipe connects one command's `stdout` to another command's `stdin`.

```bash
ls | more
```

Try:

```bash
ls -t | head
```

and:

```bash
cat sample.txt | wc -w
```

A more useful example:

```bash
grep two sample.txt | wc -l
```

---

## 10. Redirection plus pipe

```bash
head < sample.txt | grep two > result.txt
cat result.txt
```

Think of the data flow:

```text
sample.txt -> head -> grep -> result.txt
```

---

## 11. `tee`

`tee` copies a stream to both a file and the next command.

```bash
cat sample.txt | tee copy.txt | wc -l
```

Now inspect:

```bash
cat copy.txt
```

---

## Practice

1. Save the output of `ls -l` into `listing.txt`.
2. Append today's date to `listing.txt`.
3. Send the contents of `listing.txt` into `wc` using input redirection.
4. Generate an `ls` error and save only the error in `errors.txt`.
5. Run a command where normal output goes to `normal.txt` and errors go to `errors.txt`.
6. Count how many lines in `sample.txt` contain the word `two`.
7. Use `tee` to save a copy of a stream while also piping it into `wc -l`.

## Core memory

```text
<     file -> stdin
>     stdout -> file, overwrite
>>    stdout -> file, append
2>    stderr -> file
&>    stdout + stderr -> file
|     stdout of left command -> stdin of right command
```
