<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="surface[ancestor::body]">
        <xsl:element name="pb" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="corresp"><xsl:value-of select="@xml:id"/></xsl:attribute>
        </xsl:element> 
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="//body/surface/zone">
        <xsl:choose>
            <xsl:when test="@type='MainZone'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='NumberingZone'">
                <!-- <fw> (forme work) contains a running head (e.g. a header, footer), catchword, or similar material appearing on the current page. -->
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='QuireMarksZone'">
                <!-- <fw> (forme work) contains a running head (e.g. a header, footer), catchword, or similar material appearing on the current page. -->
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>   
            </xsl:when>
            <xsl:when test="@type='RunningTitleZone'">
                <!-- <fw> (forme work) contains a running head (e.g. a header, footer), catchword, or similar material appearing on the current page. -->
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='TitlePageZone'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='DropCapitalZone'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='MarginTextZone'">
                <!-- <note> (note) contains a note or annotation. -->
                <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='MarginTextZone:handwrittenAddition'">
                <!-- <note> (note) contains a note or annotation. -->
                <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='TableZone'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <!-- GraphicZone with some text? -->
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="//body/surface/zone/zone">
        <xsl:choose>
            <xsl:when test="@type='DefaultLine'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='HeadingLine'">
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='DropCapitalLine'">
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='CustomLine:BiblicalText'">
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- keep only the orig choice because we need only one text for the normalization -->
    <xsl:template match="line[ancestor::body]">
        <xsl:element name="lb" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
        </xsl:element>
        <xsl:element name="choice" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="orig" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="path[ancestor::body]"/>
    <xsl:template match="graphic[ancestor::body]"/>
    
</xsl:stylesheet>