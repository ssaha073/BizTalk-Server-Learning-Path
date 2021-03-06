<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s0 userCSharp" version="1.0" xmlns:ns0="http://ExternalCustomXSLTvsBizTalkMapper.SAPOrder" xmlns:s0="http://ExternalCustomXSLTvsBizTalkMapper.Order" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:Order" />
  </xsl:template>
  <xsl:template match="/s0:Order">
    <xsl:variable name="var:v1" select="userCSharp:GetCurrentDateTime()" />
    <ns0:SAPOrder>
      <OrderId>
        <xsl:value-of select="Orderheader/OrderNumber/text()" />
      </OrderId>
      <ClientId>
        <!-- This is a dummy value, in real scenarios we probably get this value from an external system or DB base on the client name-->
        <xsl:text>1</xsl:text>
      </ClientId>
      <Dates>
        <ProcessDate>
          <xsl:value-of select="$var:v1" />
        </ProcessDate>
        <OrderDate>
          <xsl:value-of select="Orderheader/OrderDate/text()" />
        </OrderDate>
        <EstimatedDeliveryDate>
          <xsl:value-of select="Orderheader/EstimatedDeliveryDate/text()" />
        </EstimatedDeliveryDate>
      </Dates>
      <Details>
        <ItemId>
          <xsl:value-of select="OrderDetails/ItemCustomerCode/text()" />
        </ItemId>
        <Units>
          <xsl:value-of select="OrderDetails/TotalAmount/text()" />
        </Units>
        <UnitType>
          <xsl:value-of select="OrderDetails/UnitType/text()" />
        </UnitType>
      </Details>
    </ns0:SAPOrder>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp"><![CDATA[
//********************************
//Function to get the current date
//********************************
public string GetCurrentDateTime()
{
	DateTime dt = DateTime.Now;
	string curdate = dt.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
	string curtime = dt.ToString("T", System.Globalization.CultureInfo.InvariantCulture);
	string retval = curdate + "T" + curtime;
	return retval;
}



]]></msxsl:script>
</xsl:stylesheet>