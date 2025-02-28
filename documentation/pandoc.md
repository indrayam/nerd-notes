# pandoc

## References
- [pandoc-latex-template](https://github.com/Wandmalfarbe/pandoc-latex-template)
- [Tutorial 17.3 - Markdown and Pandoc](https://www.flutterbys.com.au/stats/tut/tut17.3.html#:~:text=A%20table%20of%20contents%20can,table%20of%20contents%20is%20generated.)
- [Pandoc variables for latex](https://pandoc.org/MANUAL.html#variables-for-latex)
- [Generate Custom PDFs with Pandoc, Panrun, and The Eisvogel LaTex Template](https://forum.obsidian.md/t/generate-custom-pdfs-with-pandoc-panrun-and-the-eisvogel-latex-template/22237)

## Install pandoc

```bash
brew install pandoc
brew cask install mactex
```

## Creating PDF from Markdown

```bash
git clone git@github.com:Wandmalfarbe/pandoc-latex-template.git
cd pandoc-latex-template
mkdir -p ~/.local/share/pandoc/templates
cp eisvogel.tex ~/.local/share/pandoc/templates/eisvogel.latex
pandoc chiru.md --to=pdf -t latex -o demo.pdf --pdf-engine=/Library/TeX/texbin/pdflatex --template eisvogel
open demo.pdf
```

## Creating really professional PDF from Markdown

- [Latest version of the Eisvogel template](https://github.com/Wandmalfarbe/pandoc-latex-template/releases/latest)
- Move the two template files eisvogel.latex and eisvogel.beamer to your pandoc templates folder. 
  - On MacOS, this is usually `~/.local/share/pandoc/templates/`
- The `examples` on the [pandoc-latex-template](https://github.com/Wandmalfarbe/pandoc-latex-template) GitHub repository contains a lot of examples.
- Create a Markdown file with these additional settings (assuming you want a title page, page background, and URL support):

```markdown
---
title: "AI Engineering in EDaaS"
subtitle: "Building AI Apps using Foundational Models in EDaaS"
author: EDaaS Architect Amigos
language: "en"
date: 23-02-2025
titlepage: true
titlepage-text-color: "FFFFFF"
titlepage-rule-color: "360049"
titlepage-background: "assets/background.pdf"
page-background: "assets/background1.pdf"
titlepage-rule-height: 2
titlepage-logo: "assets/cisco-logo.pdf"
logo-width: 30mm
toc: true
toc-own-page: true
mainfont: "FiraCode Nerd Font"
sansfont: "FiraCode Nerd Font"
linkcolor: magenta
urlcolor: magenta
...

## Sample Code and Math listings

```java
public class Example implements LoremIpsum {
	public static void main(String[] args) {
		if(args.length < 2) {
			System.out.println("Lorem ipsum dolor sit amet");
		}
	} // Obscura atque coniuge, per de coniunx
}
```

\begin{equation}\label{eq:neighbor-propability}
    p_{ij}(t) = \frac{\ell_j(t) - \ell_i(t)}{\sum_{k \in N_i(t)}^{} \ell_k(t) - \ell_i(t)}
\end{equation}

\begin{equation}\label{eq:attention}
		\text{Attention}(Q, K, V) = \text{Softmax}\left(\frac{Q^T K}{\sqrt{d_k}}\right) V
\end{equation}

\begin{equation}
Attention(Q, K, V) = Softmax( (Q^T K) / sqrt(d_k) ) * V
\end{equation}

- Run the following command to generate formatted PDF:

```bash
# Source: Markdown file
pandoc aie.md -o aie.pdf --from markdown \
--template eisvogel.latex \
--listings -V colorlinks=true -V linkcolor=blue \
-V urlcolor=blue -V toccolor=gray -V toc=true \
-V toc-own-page=true

# Source: LaTeX template
pandoc test.tex -o test.pdf --from latex \
--template eisvogel.latex \
--listings -V colorlinks=true -V linkcolor=blue \
-V urlcolor=blue -V toccolor=gray -V toc=true \
-V toc-own-page=true
```

- The `--listings` option is used to enable syntax highlighting for code blocks in the PDF output.
- The `-V` option is used to set various variables for the LaTeX output. In this case, it sets the colors for links, URLs, and the table of contents.
- The `--from markdown` option specifies the input format as Markdown.
- The `--template eisvogel.latex` option specifies the LaTeX template to use for formatting the PDF.
- The `-o` option specifies the output file name.
- The `--pdf-engine` option specifies the PDF engine to use for generating the PDF. In this case, it uses `pdflatex`, which is a common LaTeX engine for generating PDFs.
