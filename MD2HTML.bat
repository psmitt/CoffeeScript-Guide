type html_start.txt > HTML\Guide.html
call node_modules\.bin\commonmark.cmd Guide.md >> HTML\Guide.html
type html_end.txt >> HTML\Guide.html
