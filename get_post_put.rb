#!/usr/bin/ruby

require 'origami'
include Origami

OUTPUTFILE = 'nradf_get_post_put.pdf'
WIDTH  = 800
HEIGHT = 600

pdf = PDF.new

contents = ContentStream.new
contents.write "If you can read this, you need a PDF viewer with XFA support (i.e. Adobe Reader).",
	:x => 20, :y => HEIGHT-40, :rendering => Text::Rendering::FILL, :size => 16

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
			<draw x="12pt" y="12pt">
				<font typeface="Helvetica" size="16pt"/>
				<value>
					<text>nradf FormCalc Get/Post/Put methods playground v0.1</text>
				</value>
			</draw>
			<draw x="557pt" y="587pt">
				<font typeface="Helvetica" size="8pt"/>
				<value>
					<text>Alexander Klink 2011 ⋅ Public Domain/CC-0 ⋅ http://www.alech.de</text>
				</value>
			</draw>

			<!-- Get() -->
			<field h="12pt" name="geturl" w="200pt" x="62pt" y="50pt">
				<font typeface="Helvetica" size="12pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>http://localhost</text>
				</value>
				<para vAlign="middle"/>
			</field>
			<field h="505pt" name="geturlcontent" w="250pt" x="12pt" y="70pt">
				<ui>
					<textEdit>
						<margin leftInset="1mm" rightInset="1mm" topInset="1mm" bottomInset="1mm"/>
					</textEdit>
				</ui>
				<font typeface="Courier" size="8pt"/>
			</field>
			<field x="22pt" y="50pt" name="getbutton">
				<event activity="click" name="getbuttonclick">
					<script contentType="application/x-formcalc">
						$form.mainform.geturlcontent.rawValue = Get($form.mainform.geturl.rawValue);
					</script>
				</event>
				<ui>
					<button/>
				</ui>
				<caption>
				<font typeface="Helvetica" size="12pt"/>
				<value>
					<text>Get</text>
				</value>
				<para vAlign="middle" hAlign="center"/>
				</caption>
				<border hand="right">
					<margin leftInset="-3mm" rightInset="-3mm" topInset="-1mm" bottomInset="-1mm"/>
					<edge stroke="raised"/>
					<fill>
						<color value="200,200,200"/>
					</fill>
				</border>
			</field>

			<!-- Post() -->
			<field h="12pt" name="posturl" w="200pt" x="325pt" y="50pt">
				<font typeface="Helvetica" size="12pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>http://localhost</text>
				</value>
				<para vAlign="middle"/>
			</field>
			<field h="20pt" name="postdata" w="250pt" x="275pt" y="70pt">
				<font typeface="Courier" size="8pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>POST data</text>
				</value>
			</field>
			<field h="10pt" name="postcontenttype" w="250pt" x="275pt" y="95pt">
				<font typeface="Courier" size="8pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>application/octet-stream</text>
				</value>
				<para vAlign="middle"/>
			</field>
			<field h="10pt" name="postcharset" w="250pt" x="275pt" y="110pt">
				<font typeface="Courier" size="8pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>UTF-8</text>
				</value>
				<para vAlign="middle"/>
			</field>
			<field h="20pt" name="postheader" w="250pt" x="275pt" y="125pt">
				<font typeface="Courier" size="8pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>X-Extra-Header: true</text>
				</value>
			</field>
			<field h="425pt" name="posturlcontent" w="250pt" x="275pt" y="150pt">
				<ui>
					<textEdit>
						<margin leftInset="1mm" rightInset="1mm" topInset="1mm" bottomInset="1mm"/>
					</textEdit>
				</ui>
				<font typeface="Courier" size="8pt"/>
			</field>
			<field x="285pt" y="50pt" name="postbutton">
				<event activity="click" name="postbuttonclick">
					<script contentType="application/x-formcalc">
						$form.mainform.posturlcontent.rawValue = Post($form.mainform.posturl.rawValue, $form.mainform.postdata.rawValue, $form.mainform.postcontenttype.rawValue, $form.mainform.postcharset.rawValue, $form.mainform.postheader.rawValue);
					</script>
				</event>
				<ui>
					<button/>
				</ui>
				<caption>
				<font typeface="Helvetica" size="12pt"/>
				<value>
					<text>Post</text>
				</value>
				<para vAlign="middle" hAlign="center"/>
				</caption>
				<border hand="right">
					<margin leftInset="-3mm" rightInset="-3mm" topInset="-1mm" bottomInset="-1mm"/>
					<edge stroke="raised"/>
					<fill>
						<color value="200,200,200"/>
					</fill>
				</border>
			</field>

			<!-- Put() -->
			<field h="12pt" name="puturl" w="200pt" x="588pt" y="50pt">
				<font typeface="Helvetica" size="12pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>http://localhost</text>
				</value>
				<para vAlign="middle"/>
			</field>
			<field h="20pt" name="putdata" w="250pt" x="538pt" y="70pt">
				<font typeface="Courier" size="8pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>PUT data</text>
				</value>
			</field>
			<field h="10pt" name="putcharset" w="250pt" x="538pt" y="95pt">
				<font typeface="Courier" size="8pt"/>
				<ui><textEdit/></ui>
				<value>
					<text>UTF-8</text>
				</value>
				<para vAlign="middle"/>
			</field>
			<field h="465pt" name="puturlcontent" w="250pt" x="538pt" y="110pt">
				<ui>
					<textEdit>
						<margin leftInset="1mm" rightInset="1mm" topInset="1mm" bottomInset="1mm"/>
					</textEdit>
				</ui>
				<font typeface="Courier" size="8pt"/>
			</field>
			<field x="548pt" y="50pt" name="putbutton">
				<event activity="click" name="putbuttonclick">
					<script contentType="application/x-formcalc">
						$form.mainform.puturlcontent.rawValue = Put($form.mainform.puturl.rawValue, $form.mainform.putdata.rawValue, $form.mainform.putcharset.rawValue);
					</script>
				</event>
				<ui>
					<button/>
				</ui>
				<caption>
				<font typeface="Helvetica" size="12pt"/>
				<value>
					<text>Put</text>
				</value>
				<para vAlign="middle" hAlign="center"/>
				</caption>
				<border hand="right">
					<margin leftInset="-3mm" rightInset="-3mm" topInset="-1mm" bottomInset="-1mm"/>
					<edge stroke="raised"/>
					<fill>
						<color value="200,200,200"/>
					</fill>
				</border>
			</field>
    </subform>
</template>
</xdp:xdp>
XEOF
xfa_form = pdf.create_xfa_form(xdp)

page = Page.new(:MediaBox => Rectangle[ :llx => 0, :lly => 0, :urx => WIDTH, :ury => HEIGHT]).setContents(contents)
pdf.append_page(page)
pdf.save(OUTPUTFILE)
