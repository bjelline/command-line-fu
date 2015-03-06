all: index.html README.md

index.html: header.html README.re.md footer.html
	cat $+ > $@

README.md: README.re.md
	egrep -v '^(class|template|name):' $+ > $@
