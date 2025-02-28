# LaTeX

## References
- [Learn LaTeX in 30 mins](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes)
- [Learn LaTeX](https://www.learnlatex.org/en/#toc)
- [LaTeX/Mathematics](https://en.wikibooks.org/wiki/LaTeX/Mathematics)
- [Markdown and LaTeX introduction](https://ashki23.github.io/markdown-latex.html))
- [Use Markdown to display mathematical expressions on GitHub.](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions)

## Math Typesetting Libraries
- [MathJax](https://www.mathjax.org/)
- [KaTeX](https://katex.org/)

## Examples

```latex
$$\begin{equation}\label{eq:neighbor-propability}
    p_{ij}(t) = \frac{\ell_j(t) - \ell_i(t)}{\sum_{k \in N_i(t)}^{} \ell_k(t) - \ell_i(t)}
\end{equation}$$
```

```latex
$$\begin{equation}\label{eq:attention}
		\text{Attention}(Q, K, V) = \text{Softmax}\left(\frac{Q^T K}{\sqrt{d_k}}\right) V
\end{equation}$$
```

```latex
$$\begin{equation}
Attention(Q, K, V) = Softmax( (Q^T K) / sqrt(d_k) ) * V
\end{equation}$$
```