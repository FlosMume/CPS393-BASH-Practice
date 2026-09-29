# CPS393 Bash Practice

A hands-on WSL/Linux practice repository organized around the Bash/Linux topics used in CPS393.

## Tutorials

- [`grep_tutorial.md`](grep_tutorial.md) — `grep`, regular expressions, pipes, and filtering
- [`io_streams_and_redirection.md`](io_streams_and_redirection.md) — `stdin`, `stdout`, `stderr`, redirection, `/dev`, pipes, and `tee`
- [`globbing_tutorial.md`](globbing_tutorial.md) — shell globbing, quoting, character classes, and Bash extended globbing
- [`bash_scripting_tutorial.md`](bash_scripting_tutorial.md) — scripts, arguments, variables, command substitution, decisions, loops, and debugging

## Practice material

- `exercises/` — text files used by the tutorials
- `exercises/glob/` — filenames specifically prepared for globbing exercises
- `scripts/` — small runnable Bash examples

## Recommended environment

WSL2 with Ubuntu is suitable for these exercises.

```bash
wsl
```

After cloning:

```bash
cd cps393-bash-practice
```

Make scripts executable if Git permissions were not preserved:

```bash
chmod +x scripts/*.sh scripts/argtest
```

## Suggested study sequence

1. I/O streams and redirection
2. Shell globbing
3. `grep` and regular expressions
4. Pipes and filters
5. Bash scripting
6. Mixed exercises combining all of the above

## Learning approach

Do not try to memorize every Bash command or option. Focus on:

- the shell's execution model;
- standard streams;
- shell expansion and quoting;
- composition with pipes;
- regular-expression filtering;
- script arguments and control flow;
- using `man` and `--help` when details are needed.
