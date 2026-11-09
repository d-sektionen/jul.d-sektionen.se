# D-sektionens Julkalender

This repository is what D-sektionen's "Julkalender" is based on.
It is built in Django and uses Javascript for some functions, like the Youtube-player.

## Why so old frontend?

Nostalgic.

## Can I change the music?

Yes, go to `julkalender\static\julkalender\js\music.js`. There you will find a lists of youtube video ids.

## Development

This project uses [uv](https://docs.astral.sh/uv/) to manage Python and its dependencies.

```sh
uv sync
uv run src/manage.py migrate
uv run src/manage.py runserver
```

Dependencies are declared in `pyproject.toml` and locked in `uv.lock`. Run `uv add <package>` to add a dependency and `uv lock` to update the lock file.
