#!/usr/bin/make
# Makefile for first-website

# if not passed default via command line
ifeq ($(.DEFAULT_GOAL),)
	.DEFAULT_GOAL := all
endif

# requires build/ to exist
# requires src/<file name>, src/emplate-head.txt, src/template-tail.txt to exist
# outputs the file build/<file name>.html
# replaces template title and description with arguments; deletes <h1><!--some text--></h1>
# arguments as so: `start <file name> <title> <description>

start = \
	cp src/template-head.txt build/$(1).html;\
	sed "s/  <title>Template<\/title>/  <title>$(2)<\/title>/" -i "build/$(1).html" ;\
	sed "s/  <meta name=\"description\" content=\"\" \/>/  <meta name=\"description\" content=\"$(3)\" \/>/" -i "build/$(1).html" ;\
	sed "s/<h1><!--h1 is usually same as title--><\/h1>//" -i "build/$(1).html" ;\
	cat src/$(1) >> build/$(1).html;\
	cat src/template-tail.txt >> build/$(1).html;

targets := index.html interactive.html about.html calendar.html contact.html calendar privacy.html resources.html programming.html

clean:
	rm -f build/*

all: clean $(targets)

images:
	ln -s ../src/images build/

styling:
	ln -s ../src/style.css build/

PGP.asc:
	ln -s ../src/PGP.asc build/

index.html: images styling
	$(call start,index,Base page,A simple website to develop my HTML and CSS skills. See README.md for more detail.)

interactive.html: images styling
	$(call start,interactive,Interactive code,Various python programs using an online compiler hosted at repl.it)

about.html: images styling
	$(call start,about,About,About the author)

calendar.html: images styling
	$(call start,calendar,Calendar,My schedule for the foreseeable future)

calendar: calendar.html
	ln -s ../src/calendar-no-extension build/calendar

contact.html: images styling PGP.asc
	$(call start,contact,Contact,Various ways to reach out to me)

privacy.html: styling
	$(call start,privacy,Why Privacy?,An argument for increased privacy in the modern Web)

programming.html: images styling
	$(call start,programming,Learn Programming,Information and resources about learning to program)

resources.html: images styling
	$(call start,resources,Resources and Links,Various links to external resources)

