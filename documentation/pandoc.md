# pandoc

[Source](https://github.com/Wandmalfarbe/pandoc-latex-template)

## Creating PDF from Markdown

```bash
git clone git@github.com:Wandmalfarbe/pandoc-latex-template.git
cd pandoc-latex-template
mkdir -p ~/.local/share/pandoc/templates
cp eisvogel.tex ~/.local/share/pandoc/templates/eisvogel.latex
#pandoc demo.md -o demo.pdf --from markdown --template eisvogel --listings
pandoc chiru.md --to=pdf -t latex -o demo.pdf --pdf-engine=/Library/TeX/texbin/pdflatex --template eisvogel
open demo.pdf
```
