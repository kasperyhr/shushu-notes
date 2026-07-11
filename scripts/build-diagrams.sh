#!/usr/bin/env bash
# ???? TikZ ???? SVG
# ??: xelatex, pdf2svg

set -euo pipefail

mkdir -p diagrams/generated

shopt -s nullglob
texfiles=(diagrams/source/*.tex)

if [ ${#texfiles[@]} -eq 0 ]; then
  echo "No .tex files found in diagrams/source"
  exit 1
fi

for texfile in "${texfiles[@]}"; do
  basename=$(basename "$texfile" .tex)
  pdf="diagrams/generated/${basename}.pdf"
  svg="diagrams/generated/${basename}.svg"

  echo "::group::Compiling ${texfile}"
  if ! xelatex -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=diagrams/generated "$texfile"; then
    echo "::error file=${texfile}::XeLaTeX failed while compiling ${texfile}"
    log="diagrams/generated/${basename}.log"
    if [ -f "$log" ]; then
      echo "===== Last 120 lines of ${log} ====="
      tail -n 120 "$log"
      echo "===== End of ${log} ====="
    else
      echo "No log file found for ${basename}"
    fi
    echo "::endgroup::"
    exit 1
  fi
  echo "::endgroup::"

  if [ ! -f "$pdf" ]; then
    echo "Expected PDF not found: $pdf"
    exit 1
  fi

  echo "Converting ${pdf} -> ${svg}..."
  pdf2svg "$pdf" "$svg"
done

rm -f diagrams/generated/*.aux diagrams/generated/*.pdf

echo "Done. SVGs in diagrams/generated/"
