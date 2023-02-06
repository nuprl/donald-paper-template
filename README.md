# Paper Template [![Typesetting CI](https://github.com/nuprl/paper-npm-data/actions/workflows/makefile.yml/badge.svg)](https://github.com/nuprl/paper-npm-data/actions/workflows/makefile.yml)

**Change the URL in the badge above to point to your own repository.**

- [Anonymous PDF with comments disabled](https://f000.backblazeb2.com/file/arjunguha-research/paper-npm-data-submission.pdf)

**Change the URL above to point to your own PDF.**

## Build Requirements:

- Python3
- Pandoc.
  + Ubuntu: `sudo apt-get install pandoc`
  + MacOS: `brew install pandoc`
- Pygments: `pip3 install pygments`
- LaTeX: Currently tested with TeX Live 2022.
  + Ubuntu: `sudo apt-get install texlive-full`
  + MacOS: `brew install texlive`


## Template Setup

1. Clone this repository.
2. Change the URLs in this README to point to your own repository and PDF.
3. Uncomment and customize the `Upload PDF to Backblaze B2` step in `.github/workflows/makefile.yml` to upload to where you want, and save the B2 credentials as secrets in your repository. Or leave it commented out if you want.
4. Customize `paper/package-config.sty`. To start, look at `\theTitle` and `\theAbstract`.
5. Edit the paper body. The body is in `paper/main.tex`, and starts around line 100.
6. Change the paper style (ACM or IEEE) by changing the definition of `\formattype` in `paper/main.tex`. 

## Usage

1. From the root of the repo, you may run `make` to build the anonymous draft PDF. You may run `make all` to build all outputs: anonymous draft, anonymous non-draft (to submit), camera-ready, arXiv ZIP, and plain text abstract. Outputs are placed in `out/`. CI will build all of these on every push.
2. From within the `paper/` directory, you may run `make` to build the paper according to the configuration in `build-config.sty`. LaTeX Workshop in VSCode and other tools will also use `build-config.sty` to build the paper,
so you can change that as needed, and it shouldn't change CI or top-level Makefile behavior.


## Tips

To embed all fonts for a camera ready:

       gs -q -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=main-embedded.pdf \
         -dCompatibilityLevel=1.5 -dPDFSETTINGS=/prepress -c .setpdfwrite -f main.pdf
