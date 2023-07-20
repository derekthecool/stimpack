# Stimpack Luasnip Coverage

Snippets are magic. Snippets and autosnippets are a core feature of steno
programming. This table is a graph showing basic snippet coverage for various
programming languages and filetypes.

My snippet triggers are just the normal keywords but capitalized, so to trigger
a while loop I use the text `WHILE`.

Check [My PloverStenoDictionaries](https://github.com/derekthecool/PloverStenoDictionaries/blob/master/plover/neovim/neovim_core_commands.md#core-programming-items)
for the full current list of triggers.

Here the list with a basic description if needed.

- IF
- ELS_EI_F: spelled weird to not conflict with the IF and ELSE triggers
- ELSE
- FOR
- WHILE
- FOREACH: loop through a sequence or list
- FUNCTION
- PRINT: normal printing to stdout
- ERRORPRINT: normal printing to stderr
- INCLUDE: most languages have some sort of include. Map to what makes sense,
  (python:import, csharp:using, lua:require)
- DEFINE: define constants
- FORMAT: format a string. Could be used inside a print statement or be assigned
  to a variable. But by itself it just formats.
- TASK: async programming
- TRY: error catching block start
- CLASS: create a class
- CONSTRUCTOR: create a constructor for a class

| Language - [FileTypes] | `FOR` | `WHILE` | `IF` | Else If stenoed as ELS_EI_F | ELSE | PRINT | ERRORPRINT | `INCLUDE` | `DEFINE` | FORMAT | TASK | TRY | CLASS | CONSTRUCTOR |
| ---------------------- | ----- | ------- | ---- | --------------------------- | ---- | ----- | ---------- | --------- | -------- | ------ | ---- | --- | ----- | ----------- |
| C - [`.c,.h`]          | ✔️     | ✔️       | ✔️    | ✔️                           | ✔️    | ✔️     | ✔️          | ✔️         | ✔️        | ✔️      | ✔️    | ✔️   | ⛔    | ⛔          |
| lua                    | ✔️     | ✔️       | ✔️    | ✔️                           | ✔️    | ✔️     |            |           |          | ✔️      |      |     |       |             |
|                        |       |         |      |                             |      |       |            |           |          |        |      |     |       |             |
|                        |       |         |      |                             |      |       |            |           |          |        |      |     |       |             |
