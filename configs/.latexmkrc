# .latexmkrc starts
$pdf_previewer = "zathura %O %S";
#$pdflatex = "xelatex -synctex=1 -interaction=nonstopmode";
$pdflatex = "pdflatex --shell-escape %O %S";
$cleanup_mode = 2;
$clean_ext = "*.gz";
$preview_continuous_mode = 1;
$pdf_mode = 1;
# .latexmkrc ends
