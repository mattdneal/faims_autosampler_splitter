@echo off
set /p dir="Enter full directory path of FAIMS autosampler run: "
set /p ext="Enter extension of converted FAIMS files ("asc" (no quotes) if converted using multi-converter, "txt" if converted by hand): "
"C:\Program Files\R\R-3.3.2\bin\Rscript.exe" splitter.R "%DIR%" "%EXT%"
pause