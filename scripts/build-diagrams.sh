 #!/bin/bash
 # 本地编译 TikZ 图并生成 SVG
 # 需要: xelatex, pdf2svg
 set -e
 
 mkdir -p diagrams/generated
 
 for texfile in diagrams/source/*.tex; do
   basename=$(basename "$texfile" .tex)
   echo "Compiling $basename..."
   xelatex -interaction=nonstopmode -output-directory=diagrams/generated "$texfile"
   pdf2svg "diagrams/generated/${basename}.pdf" "diagrams/generated/${basename}.svg"
 done
 
 rm -f diagrams/generated/*.aux diagrams/generated/*.log diagrams/generated/*.pdf
 echo "Done. SVGs in diagrams/generated/"
