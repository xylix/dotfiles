# Scratch files

Use `tmp/` at the root of the current project for scratch and temporary files: helper scripts, intermediate results, downloaded files, extracted archives, and any output that does not belong in the project proper. Create the directory if it does not exist. Prefer this over the session scratchpad directory or system temp directories like `/tmp`, unless I explicitly ask otherwise.

`tmp/` is ignored by the global gitignore, so nothing written there will be committed.

# Committing

Ask the user, or if the user instructed you to do commits, review changes before committing. For large changes, consider what approach is reasonable. If the project has tests, running tests before committing is a good idea. If the project is a script with side effects, consider whether to run it or not, and ask the user if unclear.
