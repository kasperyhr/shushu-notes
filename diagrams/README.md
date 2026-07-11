 # 图形系统
 
 术数笔记的 TikZ 图形系统，用于辅助复习和理解，不替代文字表格。
 
 ## 目录说明
 
 - **`source/`**：TikZ 源文件（`.tex`）。每个文件可独立用 XeLaTeX 编译。
 - **`generated/`**：自动生成的 SVG 图片，由 GitHub Actions 在 push 后自动编译。
 
 ## 使用方式
 
 1. 在 `source/` 中修改或新增 `.tex` 文件。
 2. Push 到 GitHub，GitHub Actions 自动编译并生成 SVG。
 3. Markdown 文档中引用 `generated/` 中稳定文件名：
 
 ```markdown
 ![五行关系图](../../diagrams/generated/five-elements-relations.svg)
 ```
 
 ## 本地编译
 
 如果本地安装了 XeLaTeX 和 pdf2svg，可运行：
 
 ```bash
 bash scripts/build-diagrams.sh
 ```
 
 生成的 SVG 在 `diagrams/generated/` 目录中。
 
 ## 图片清单
 
 | 文件名 | 用途 |
 |--------|------|
 | `earthly-branches-base-circle.svg` | 十二地支基础圆环 |
 | `earthly-branches-liuhe.svg` | 六合图 |
 | `earthly-branches-liuchong.svg` | 六冲图 |
 | `earthly-branches-sanhe-banhe.svg` | 三合半合图 |
 | `earthly-branches-sanhui.svg` | 三会图 |
 | `earthly-branches-xing.svg` | 相刑图 |
 | `earthly-branches-hai.svg` | 相害图 |
 | `earthly-branches-po.svg` | 相破图 |
 | `earthly-branches-all-relations.svg` | 地支关系总览图 |
 | `five-elements-relations.svg` | 五行生克图 |
 | `yin-yang-four-images.svg` | 阴阳四象图 |
