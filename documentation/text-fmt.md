# text-fmt

Source: [tex-fmt](https://github.com/WGUNDERWOOD/tex-fmt)

An extremely fast LaTeX formatter written in Rust.

## Useful Commands

```bash
tex-fmt file.tex                  # format file.tex and overwrite
tex-fmt --check file.tex          # check if file.tex is correctly formatted
tex-fmt --print file.tex          # format file.tex and print to stdout
tex-fmt --fail-on-change file.tex # format file.tex and return exit-code 1 if overwritten
tex-fmt --nowrap file.tex         # do not wrap long lines
tex-fmt --stdin                   # read from stdin and print to stdout
tex-fmt --help                    # view help information
```