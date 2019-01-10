# pandoc

[Source](https://github.com/Wandmalfarbe/pandoc-latex-template)

## Creating PDF from Markdown

```bash
git clone git@github.com:Wandmalfarbe/pandoc-latex-template.git
cd pandoc-latex-template
cp eisvogel.tex /usr/local/Cellar/pandoc/2.5/share/x86_64-osx-ghc-8.4.4/pandoc-2.5/data/templates/eisvogel.latex
pandoc demo.md -o demo.pdf --from markdown --template eisvogel --listings
open demo.pdf
```
