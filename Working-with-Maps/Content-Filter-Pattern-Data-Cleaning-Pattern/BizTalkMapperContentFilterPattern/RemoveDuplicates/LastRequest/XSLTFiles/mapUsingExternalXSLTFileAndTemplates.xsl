<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var" version="1.0" xmlns:ns0="http://BizTalkMapperContentFilterPattern.ApplicationForms">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/ns0:ApplicationForms" />
  </xsl:template>
  <xsl:template match="/ns0:ApplicationForms">
    <ns0:ApplicationForms>
      <xsl:variable name="sorted">
        <Forms>
        <xsl:apply-templates select="Form">
          <xsl:sort select="concat(FullName,RequestDate)"/>
        </xsl:apply-templates>
        </Forms>
      </xsl:variable>
      
      <xsl:variable name="sortedNodeSet" select="msxsl:node-set($sorted)/Forms"/> 
      
      <xsl:for-each select="$sortedNodeSet/*">
        <xsl:if test="(FullName != following-sibling::*[1]/FullName) or (position() = last())">
          <xsl:copy-of select="."/>
        </xsl:if>
      </xsl:for-each>
      
      
      
      
    </ns0:ApplicationForms>
  </xsl:template>
  <xsl:template name="SortFrom" match="Form">
    <xsl:copy-of select="."/>
  </xsl:template>
</xsl:stylesheet>