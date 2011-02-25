#!/usr/bin/ruby

require 'origami'
include Origami

OUTPUTFILE = 'nradf_get_post_put.pdf'
WIDTH  = 800
HEIGHT = 600

pdf = PDF.new

contents = ContentStream.new
#contents.write "FormCalc Get() method",
#	:x => 20, :y => HEIGHT-40, :rendering => Text::Rendering::FILL, :size => 30

xdp =<<'XEOF'
<?xml version="1.0" encoding="UTF-8"?>
<xdp:xdp xmlns:xdp="http://ns.adobe.com/xdp/">
<config xmlns='http://www.xfa.org/schema/xci/3.0/'>
  <present>
    <pdf>
      <interactive>1</interactive>
    </pdf>
  </present>
  <acrobat>
    <acrobat7>
      <dynamicRender>required</dynamicRender>
    </acrobat7>
  </acrobat>
</config>
<template xmlns="http://www.xfa.org/schema/xfa-template/2.5/">
    <subform layout="position" locale="en_US" name="mainform">
        <pageSet>
            <pageArea id="Page1" name="Page1">
                <contentArea h="600pt" w="800pt" x="0pt" y="0pt"/>
                <medium long="800pt" short="600pt" stock="default" orientation="landscape"/>
            </pageArea>
        </pageSet>
			<draw x="10pt" y="10pt">
				<font typeface="Helvetica" size="16pt"/>
				<value>
					<text>nradf FormCalc Get/Post/Put methods playground v0.1</text>
				</value>
			</draw>
			<field h="12pt" name="url" w="200pt" x="50pt" y="50pt">
				<ui><textEdit/></ui>
				<value>
					<text>http://localhost</text>
				</value>
			</field>
			<draw x="5pt" y="100pt" name="getcontent">
				<font typeface="Courier" size="10pt"/>
			</draw>
			<field h="400pt" name="urlcontent" w="250pt" x="5pt" y="100pt">
				<ui><textEdit/></ui>
			</field>
			<field x="20pt" y="50pt" name="getbutton">
				<event activity="click" name="getbuttonclick">
					<script contentType="application/x-formcalc">
						$form.mainform.urlcontent.rawValue = Get($form.mainform.url.rawValue);
					</script>
				</event>
				<ui>
					<button highlight="inverted"/>
				</ui>
				<caption>
				<value>
					<text>Get</text>
				</value>
				</caption>
			</field>
    </subform>
</template>
</xdp:xdp>
XEOF
xfa_form = pdf.create_xfa_form(xdp)

#js = Action::JavaScript.new("app.alert(\"foo\")")
#pdf.onDocumentOpen(js)

page = Page.new(:MediaBox => Rectangle[ :llx => 0, :lly => 0, :urx => WIDTH, :ury => HEIGHT]).setContents(contents)
#page.add_font(Name.new('F1'), Font::Type1::Standard::Helvetica.new())
pdf.append_page(page)
pdf.save(OUTPUTFILE)
