.PHONY: all clean .FORCE out/arxiv.pdf.noclean


out/conference-camera-ready.pdf: .FORCE
	mkdir -p out/
	scripts/build_with_config.sh out/conference-camera-ready.pdf '\\newif\\ifisdraft\\isdraftfalse\n\\newif\\ifisanonymous\\isanonymousfalse\n\\newif\\ifisarxiv\\isarxivfalse'
	cd paper/; latexmk -c; rm -f main.pdf main.abstract.output

out/conference-camera-ready-embedded.pdf: out/conference-camera-ready.pdf
	gs -q -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=out/conference-camera-ready-embedded.pdf -dCompatibilityLevel=1.5 -dPDFSETTINGS=/prepress out/conference-camera-ready.pdf

out/conference-draft.pdf: .FORCE
	mkdir -p out/
	scripts/build_with_config.sh out/conference-draft.pdf '\\newif\\ifisdraft\\isdrafttrue\n\\newif\\ifisanonymous\\isanonymoustrue\n\\newif\\ifisarxiv\\isarxivfalse'
	cd paper/; latexmk -c; rm -f main.pdf main.abstract.output

out/conference-submit.pdf: .FORCE
	mkdir -p out/
	scripts/build_with_config.sh out/conference-submit.pdf '\\newif\\ifisdraft\\isdraftfalse\n\\newif\\ifisanonymous\\isanonymoustrue\n\\newif\\ifisarxiv\\isarxivfalse'
	cd paper/; latexmk -c; rm -f main.pdf main.abstract.output



out/arxiv.pdf.noclean: .FORCE
	mkdir -p out/
	scripts/build_with_config.sh out/arxiv.pdf '\\newif\\ifisdraft\\isdraftfalse\n\\newif\\ifisanonymous\\isanonymousfalse\n\\newif\\ifisarxiv\\isarxivtrue'

out/arxiv.pdf: out/arxiv.pdf.noclean
	cd paper/; latexmk -c; rm -f main.pdf main.abstract.output

out/arxiv.zip: out/arxiv.pdf.noclean
	mkdir -p out/
	rm -rf out/arxiv/
	rm -f out/arxiv.zip
	cp paper/main.bbl main.bbl
	cd paper/; latexmk -c; rm -f main.pdf

	cp -R paper/ out/arxiv/
	rm -rf out/arxiv/.texpadtmp/
	rm -f out/arxiv/.gitignore
	rm -f out/arxiv/latexmkrc
	rm -f out/arxiv/Makefile
	rm -f out/arxiv/.DS_Store
	rm -f out/arxiv/main.pdf
	rm -f out/arxiv/main-embedded.pdf
	rm -f out/arxiv/TODO.md
	rm -f out/arxiv/slides.key
	rm -f out/arxiv/main.abstract.output
	rm -rf out/arxiv/bib/
	echo '\\newif\\ifisdraft\\isdraftfalse\n\\newif\\ifisanonymous\\isanonymousfalse\n\\newif\\ifisarxiv\\isarxivtrue' > out/arxiv/build-config.sty

	mv main.bbl out/arxiv/
	cd out/; zip -r arxiv.zip arxiv/


out/abstract.md: .FORCE
	mkdir -p out/
	scripts/build_with_config.sh out/conference-camera-ready.pdf '\\newif\\ifisdraft\\isdraftfalse\n\\newif\\ifisanonymous\\isanonymousfalse\n\\newif\\ifisarxiv\\isarxivfalse'
	scripts/abstract_latex_to_md.sh paper/main.abstract.output out/abstract.md
	cd paper/; latexmk -c; rm -f main.pdf main.abstract.output


all: out/conference-draft.pdf out/conference-submit.pdf out/conference-camera-ready.pdf out/arxiv.pdf.noclean out/arxiv.zip out/abstract.md
	cd paper/; latexmk -c; rm -f main.pdf main.abstract.output

clean:
	cd paper/; latexmk -c; rm -f main.pdf main.abstract.output
	rm -rf out/
