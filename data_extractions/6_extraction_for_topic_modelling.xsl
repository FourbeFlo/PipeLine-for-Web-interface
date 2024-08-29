<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    
    <!-- Identity template to copy all nodes by default 
    
    <xsl:template match="@*|node()">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>
    -->
    <xsl:template match="teiHeader"/>
    <xsl:template match="sourceDoc"/>
    <xsl:template match="orig"/>
    
    <xsl:template match="choice">
        <xsl:choose>
            <xsl:when test="reg">
        <xsl:value-of select=" descendant::reg"/>
            <xsl:choose>
                <xsl:when test="reg/seg">
                    <xsl:element name="haed">
                        
                        <xsl:value-of select="reg/seg/@type"/>
                    </xsl:element>   
                </xsl:when>
            </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
