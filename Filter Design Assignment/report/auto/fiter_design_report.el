(TeX-add-style-hook
 "fiter_design_report"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "22pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "a4paper" "tmargin=1in" "bmargin=1in") ("inputenc" "utf8")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "geometry"
    "inputenc"
    "graphicx"
    "parskip"
    "pdflscape"
    "listings"
    "hyperref"
    "float"
    "caption"
    "subcaption"
    "amsmath")
   (TeX-add-symbols
    "ra")
   (LaTeX-add-labels
    "eq:1"
    "eq:2"
    "fig:1"
    "fig:2"
    "fig:3"
    "fig:4"
    "fig:5"
    "fig:6"
    "fig:7"
    "fig:8"
    "eq:3"
    "eq:4")
   (LaTeX-add-bibliographies
    "ref"))
 :latex)

