# mandocset

This is python script (mandocset.py) that generates Dash docset from man pages. It takes folders with man pages as it's arguments. Then in each folder it finds all folders, containing digit in their name, runs `man2html -r` for each file inside them.

By default script uses man2html utility. If you prefer pandoc just use `-e "pandoc -f man -t html"`.

---

This is a loose fork of [Yanpas' repository](https://github.com/Yanpas/mandocset), forked to help package additional man page collections. Currently, this fork only supports Debian and Debian-based systems.

### Prerequisites

- `apt-file`
- `coreutils`
- `make`
- `man2html`
- `python3`

```
# apt install apt-file coreutils make man2html python3
```

### Usage

Available docsets to build are listed under `getters/`. To build a docset, run `make DOCSET=[DOCSET]`, where `[DOCSET]` is the docset you wish to generate (the name of the script in `getters/` minus the extension). Additional make directives include:

- `make clean` - remove the directories created when building the docset
- `make tgz` - Create a .tgz archive for easily submitting to [Dash-User-Contributions](https://github.com/Kapeli/Dash-User-Contributions)
