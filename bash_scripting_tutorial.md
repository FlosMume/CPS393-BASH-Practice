# Bash Scripting Practice

## 1. Why use a script?

Interactive shell commands are convenient for one-off tasks. A script is useful when a sequence of commands should be saved, repeated, tested, or shared.

---

## 2. Your first script

Create:

```bash
nano hello.sh
```

Enter:

```bash
#!/bin/bash

echo "Hello from Bash"
```

Save, then make it executable:

```bash
chmod +x hello.sh
```

Run:

```bash
./hello.sh
```

The first line is the shebang:

```bash
#!/bin/bash
```

It tells the system which interpreter should run the script.

---

## 3. Exit status

Add:

```bash
exit 0
```

A zero exit status conventionally means success.

After running a command or script:

```bash
echo $?
```

shows its exit status.

---

## 4. Script arguments

Create:

```bash
nano argtest
```

Use:

```bash
#!/bin/bash

echo "Script name: $0"
echo "Number of args: $#"
echo "First arg: $1"
echo "Second arg: $2"
echo "All args individually: $@"
echo "All args as one expansion: $*"
```

Then:

```bash
chmod +x argtest
./argtest hello world
```

Key variables:

```text
$0   script name
$1   first argument
$2   second argument
$#   number of arguments
$@   all arguments
$*   all arguments
```

If no arguments are passed, `$1`, `$2`, and so on are empty.

---

## 5. Variables

Create:

```bash
name="Samuel"
course="CPS393"
```

Important: do not put spaces around `=`.

Use variables:

```bash
echo "$name"
echo "$course"
```

Prefer double quotes around variable expansions unless you specifically want word splitting or glob expansion.

---

## 6. Command substitution

Capture command output:

```bash
today=$(date)
echo "Today is $today"
```

Another example:

```bash
count=$(ls | wc -l)
echo "There are $count directory entries"
```

---

## 7. `if` statements

Example:

```bash
#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "No arguments supplied"
else
    echo "You supplied $# arguments"
fi
```

Run it both ways:

```bash
./checkargs.sh
./checkargs.sh one two
```

---

## 8. Test a file

```bash
#!/bin/bash

if [ -f "$1" ]; then
    echo "$1 is a regular file"
else
    echo "$1 is not a regular file"
fi
```

Try:

```bash
./filecheck.sh /etc/passwd
./filecheck.sh does_not_exist
```

---

## 9. `for` loop

```bash
#!/bin/bash

for arg in "$@"; do
    echo "Argument: $arg"
done
```

Run:

```bash
./showargs.sh one "two words" three
```

Quoting `"$@"` preserves each argument correctly.

---

## 10. Loop over files using globbing

```bash
#!/bin/bash

for f in *.txt; do
    echo "Text file: $f"
done
```

This combines scripting with shell globbing.

---

## 11. `while` loop

```bash
#!/bin/bash

n=1

while [ "$n" -le 5 ]; do
    echo "$n"
    n=$((n + 1))
done
```

---

## 12. Pipelines inside scripts

A script can combine commands exactly as you do interactively.

Example:

```bash
#!/bin/bash

grep ComputerScience ../exercises/students.txt | wc -l
```

Or a more descriptive version:

```bash
#!/bin/bash

count=$(grep ComputerScience ../exercises/students.txt | wc -l)
echo "ComputerScience students: $count"
```

---

## 13. A CPS393-style filtering script

Example:

```bash
#!/bin/bash

who | grep "$1" | cut -c1-8 | uniq
```

Run:

```bash
./finduser your_user_name
```

This demonstrates the Unix idea of building a result by composing small filters.

---

## 14. Debugging a script

Syntax check:

```bash
bash -n script.sh
```

Trace commands as they execute:

```bash
bash -x script.sh
```

You can also temporarily add:

```bash
set -x
```

inside a script.

---

## Practice

1. Write `greet.sh` that prints `Hello NAME`, where `NAME` is `$1`.
2. Write `argcount.sh` that prints the number of arguments.
3. Write `filecheck.sh` that reports whether `$1` is a regular file.
4. Write `txtfiles.sh` that loops through all `.txt` files.
5. Write `cs_count.sh` that counts `ComputerScience` lines in `exercises/students.txt`.
6. Write `search.sh` that accepts a search string as `$1` and a filename as `$2`, then runs `grep`.
7. Modify `search.sh` so it prints a useful message when fewer than two arguments are supplied.

## Suggested solution for `search.sh`

```bash
#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 PATTERN FILE"
    exit 1
fi

grep "$1" "$2"
```

## Core memory

```text
#!/bin/bash      interpreter
$0               script name
$1, $2, ...      positional arguments
$#               number of arguments
$@               all arguments
name=value       assignment
"$name"           safe variable expansion
$(command)       command substitution
if ... fi        decision
for ... do ... done
while ... do ... done
```
