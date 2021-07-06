import nake, std/strformat

task "docs", "Generate documentation":
  # https://nim-lang.github.io/Nim/docgen.html
  let
    sums = "sums"
    src = sums.addFileExt(".nim")
    dir = "docs/"
    doc = dir / sums.addFileExt(".html")
    url = "https://github.com/planetis-m/sums"
  if doc.needsRefresh(src):
    echo "Generating the docs..."
    direShell(nimExe,
        &"doc --verbosity:0 --git.url:{url} --git.devel:master --git.commit:master --out:{dir} {src}")
    withDir(dir):
      moveFile("theindex.html", "index.html")
  else:
    echo "Skipped generating the docs."

task "test", "Run the tests":
  withDir("tests/"):
    for f in walkFiles("t*.nim"):
      echo "Running test ", f, "..."
      direShell(nimExe, &"c -r --hints:off -w:off --path:../ {f}")
