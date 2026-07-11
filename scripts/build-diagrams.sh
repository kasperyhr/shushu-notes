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
  stdout="diagrams/generated/${basename}.stdout"
  log="diagrams/generated/${basename}.log"

  echo "::group::Compiling ${texfile}"
  echo "Compiling ${texfile}..."

  if ! xelatex -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=diagrams/generated "$texfile" > "$stdout" 2>&1; then
    echo "::error file=${texfile}::XeLaTeX failed while compiling ${texfile}"
    echo "===== XeLaTeX stdout for ${texfile} ====="
    tail -n 160 "$stdout" || true
    echo "===== Last 160 lines of ${log} ====="
    if [ -f "$log" ]; then
      tail -n 160 "$log" || true
    else
      echo "No log file found: $log"
    fi
    echo "::endgroup::"
    exit 1
  fi

  echo "XeLaTeX succeeded for ${texfile}"

  if [ ! -f "$pdf" ]; then
    echo "::error file=${texfile}::Expected PDF not found: $pdf"
    echo "===== XeLaTeX stdout for ${texfile} ====="
    tail -n 160 "$stdout" || true
    echo "::endgroup::"
    exit 1
  fi

  echo "Converting ${pdf} -> ${svg}..."
  if ! pdf2svg "$pdf" "$svg"; then
    echo "::error file=${texfile}::pdf2svg failed for ${pdf}"
    ls -lah diagrams/generated || true
    echo "::endgroup::"
    exit 1
  fi

  if [ ! -f "$svg" ]; then
    echo "::error file=${texfile}::Expected SVG not found: $svg"
    ls -lah diagrams/generated || true
    echo "::endgroup::"
    exit 1
  fi

  echo "Generated ${svg}"
  echo "::endgroup::"
done

rm -f diagrams/generated/*.aux

echo "Generated files:"
find diagrams/generated -maxdepth 1 -type f -print | sort
