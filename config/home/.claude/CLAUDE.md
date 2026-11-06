# Scratch files

Prefer a within-project tmp/ over using the / global claude paths for scratchpad files.
`tmp/` is ignored by the global gitignore, so nothing written there will be committed. 

# Committing

Ask the user, or if the user instructed you to do commits, review changes before committing. For large changes, consider what approach is reasonable. If the project has tests, running tests before committing is a good idea. If the project is a script with side effects, consider whether to run it or not, and ask the user if unclear.

# Python

Use `uv` for Python instead of creating virtualenvs or calling `pip` directly. For one-off scripts that need packages, prefer inline script metadata (`# /// script` with `dependencies = [...]`) and run `uv run script.py`, or `uv run --with <dependency>` . Do not create a scratch venv with `python3 -m venv`.
