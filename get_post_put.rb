#!/usr/bin/ruby

require 'origami'
include Origami

OUTPUTFILE = 'nradf_get_post_put.pdf'
WIDTH  = 800
HEIGHT = 600

pdf = PDF.new

contents = ContentStream.new
contents.write "FormCalc Get() method",
	:x => 20, :y => HEIGHT-40, :rendering => Text::Rendering::FILL, :size => 30

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
                <contentArea h="600pt" w="800pt" x="50pt" y="50pt"/>
                <medium long="800pt" short="600pt" stock="default" orientation="landscape"/>
            </pageArea>
        </pageSet>
			<field h="15pt" name="url" w="200pt" x="5pt" y="5pt">
				<ui><textEdit/></ui>
				<value>
					<text>http://localhost</text>
				</value>
			</field>
			<field h="400pt" name="urlcontent" w="600pt" x="5pt" y="30pt">
				<ui><textEdit/></ui>
			</field>
			<field h="0pt" name="trigger" w="0pt" x="0mm" y="0mm">
				<event activity="enter" name="communicate">
					<script contentType="application/x-formcalc">
						$form.mainform.subform.urlcontent.rawValue = Get($form.mainform.subform.url.rawValue);
					</script>
				</event>
				<ui><textEdit/></ui>
			</field>
    </subform>
</template>
</xdp:xdp>
XEOF
xfa_form = pdf.create_xfa_form(xdp)

page = Page.new(:MediaBox => Rectangle[ :llx => 0, :lly => 0, :urx => WIDTH, :ury => HEIGHT]).setContents(contents)
pdf.append_page(page)
pdf.save(OUTPUTFILE)
