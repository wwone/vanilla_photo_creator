# vanilla_photo_creator
Vanilla Photo Creator is a Perl script that makes static "photo pages" for the web. This simple layout works very well, both on the desktop, and in phones and tablets.

Vanilla (https://vanillaframework.io/) is a big step up in CSS layout for multiple devices. (I've tried several.)

There are 3 input files:

"project"_input.txt -- input file, contains links to full-size and thumbnail images, as well as title narrative (see doc)

"project"_vtront.txt -- boilerplate for beginning of web page

"project"_vback.txt -- boilerplate for end of web page

makeweb.pl -- the Perl script that reads the "project"-specific text files and creates:

"project"_vtest.html -- HTML file that can then be used

NOTE: the example "_vfront.txt" boilerplate file provided here refers to the local copy of the Vanilla CSS file. You should alter all project-specific boilerplate files to point to the appropriate CSS file.

An example output of this Perl script is live at:

http://swansongrp.com/photos_night.html

along with several others.
