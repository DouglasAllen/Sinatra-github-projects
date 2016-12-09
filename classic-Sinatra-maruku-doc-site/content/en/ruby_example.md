CSS: style.css
Use numbered headers: true
HTML use syntax: true
LaTeX use listings: true
LaTeX CJK: false
LaTeX preamble: preamble.tex

![MaRuKu](logo.png){#logo}

**Hello World!**
================

{:ruby:     lang=ruby code_background_color='#efffef'}
	require 'rubygems'
	require 'maruku'
	
	markdown_string = '**Hello World!**\n============'
        
	doc = Maruku.new(markdown_string)
	puts doc.to_html
	
	irb(main):001:0> require 'rubygems'
	=> false
	irb(main):002:0> require 'maruku'
	=> true
	irb(main):003:0>
	irb(main):004:0* markdown_string = '**Hello World!**\n============'
	=> "**Hello World!**\\n============"
	irb(main):005:0>
	irb(main):006:0* doc = Maruku.new(markdown_string)
	=> md_el(:document, md_par([md_strong("Hello World!"), "\\n============"]))
	irb(main):007:0> puts doc.to_html
	
	<p><strong>Hello World!</strong>\n============</p>
	=> nil

{:ruby}