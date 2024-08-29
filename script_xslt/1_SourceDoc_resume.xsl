<?xml version="1.0" encoding="UTF-8"?>
    <!-- Source XSL : Simon Gabay ; adaptation : Sonia Solfrini : apaptation Floriane Goy aout 2024  -->
    
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xpath-default-namespace="http://www.loc.gov/standards/alto/ns-v4#" version="2.0"
        exclude-result-prefixes="xs">
        <xsl:output encoding="UTF-8" method="xml" indent="yes"
            xpath-default-namespace="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng"/>
        
        <xsl:strip-space elements="*"/>
        <!-- Changer les variables suivantes si nécessaire -->
        <!-- Les variables permettent de reconstituer l'url des documents -->
        
        <xsl:variable name="document">Lambertus_tim_essaie</xsl:variable>
        <xsl:variable name="fileName">doc_2</xsl:variable>
        <xsl:variable name="nma">https://www.e-rara.ch/</xsl:variable>
        <xsl:variable name="iiif-name">i3f/v20/</xsl:variable>
        <xsl:variable name="endfile">/full/0/default.jpg</xsl:variable>
        
        <!-- template for coordinates with a specific path, specific path in the $context value -->
        <xsl:template name="coordinate-with-context" xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:param name="context"/>
            <xsl:attribute name="ulx">
                <xsl:value-of select="$context/@HPOS"/>
            </xsl:attribute>
            <xsl:attribute name="uly">
                <xsl:value-of select="$context/@VPOS"/>
            </xsl:attribute>
            <xsl:attribute name="lrx">
                <xsl:value-of select="number($context/@HPOS) + number($context/@WIDTH)"/>
            </xsl:attribute>
            <xsl:attribute name="lry">
                <xsl:value-of select="number($context/@VPOS) + number($context/@HEIGHT)"/>
            </xsl:attribute>
        </xsl:template>
        
        <!-- template for coordinates only : ulx, uly, lrx, lry-->
        <xsl:template name="cordinate-only" xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="ulx">
                <xsl:value-of select="@HPOS"/>
            </xsl:attribute>
            <xsl:attribute name="uly">
                <xsl:value-of select="@VPOS"/>
            </xsl:attribute>
            <xsl:attribute name="lrx">
                <xsl:value-of select="number(@HPOS) + number(@WIDTH)"/>
            </xsl:attribute>
            <xsl:attribute name="lry">
                <xsl:value-of select="number(@VPOS) + number(@HEIGHT)"/>
            </xsl:attribute>
        </xsl:template>
        
        <!-- line number template : n=number -->
        <xsl:template name="n-attribute" xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:number level="single" count="." format="1"/>
            </xsl:attribute>
        </xsl:template>
        
        <!-- template to build the <source> element-->
        <xsl:template name="build-source" xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:param name="endfile"/>
            <xsl:attribute name="source">
                <xsl:value-of
                    select="substring-before(ancestor-or-self::alto/Description/sourceImageInformation/fileIdentifier, 'full/full')"/>
                <xsl:value-of select="@HPOS"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="@VPOS"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="@WIDTH"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="@HEIGHT"/>
                <xsl:value-of select="$endfile"/>
            </xsl:attribute>
        </xsl:template>
        
        <!-- template pair of points
             to retrieve points and format pairs of coordinates
             example: points="968,165 243,733 462,165 243,733 462,234 357,641 968,234 357,641 968,165 "/>
             the coordinates are made up of two points around a comma, separated by a space--> 
                                        
        <xsl:template name="point-pair" xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="points">
                <xsl:variable name="value" select="./Shape/Polygon/@POINTS"/>
                <xsl:analyze-string select="$value" regex="([0-9]+)\s([0-9]+)">
                    <xsl:matching-substring>
                        <xsl:for-each select="$value">
                            <xsl:value-of select="regex-group(1)"/>
                            <xsl:text>,</xsl:text>
                            <xsl:value-of select="regex-group(2)"/>
                            <xsl:text> </xsl:text>
                        </xsl:for-each>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:attribute>
        </xsl:template>
        
        <!-- Changer le "path" si nécessaire : 'file:/home/floriane/Documents/PaulPipeline/fgTEIpipeLine/data/' -->
        
        <xsl:variable name="xmlDocuments" select="collection(concat('file:/home/floriane/Documents/PaulPipeline/chap3-4-pipeline/data/', $fileName, '/?select=?*.xml;recurse=yes'))"/>
        <!-- Pour l'instant j'utilise l'odd construit par Sonia Solfrini pour le projet SETAF avec quelques modifications mineurs -->      
        <xsl:template match="/" >
            <xsl:processing-instruction name="xml-model">
            <xsl:text>"file:/home/floriane/Documents/PaulPipeline/chap3-4.pipeline/odd-setaf-rw-FG.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
        </xsl:processing-instruction>
            <xsl:processing-instruction name="xml-model">
            <xsl:text>"file:/home/floriane/Documents/PaulPipeline/chap3-4.pipeline/odd-setaf-rw-FG.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>
        </xsl:processing-instruction>
            <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$document}">
                   
<!-- teiHeader -->               
                <teiHeader>
                    
                    <fileDesc>
                        <titleStmt>
                            <title>In D. Pauli priorem Epistolam ad Timotheum commentarius [Geneva] : [Lambertus Dannaeus], [1577]</title>
                            <respStmt>
                                <resp>FNS Paul exegesis projet.</resp>
                                <persName xml:id="UZ">
                                    <forename>Ueli</forename>
                                    <surname>Zahnd</surname>
                                    <ptr type="orcid" target="0000-0002-6129-1687"/>
                                </persName>
                            </respStmt>
                            <respStmt>
                                <resp>Modelling and document engineering, segmentation and correction of OCR transcription, conversion to TEI, metadata encoding.</resp>
                                <persName xml:id="FG">
                                    <forename>Floriane</forename>
                                    <surname>Goy</surname>
                                    <ptr type="orcid" target="0009-0005-9944-035X"/>
                                </persName>
                            </respStmt>
                        </titleStmt>
                        <extent>
                            <measure unit="total_images" n="48"/>
                            <measure unit="processed_images" n="16"/>
                        </extent> 
                        <publicationStmt>
                            <publisher>16th Century Exegesis of Paul</publisher>
                            <authority>Institut d'Histoire de la Réformation (IHR), université de Genève</authority>
                            <address>
                                <addrLine>22 boulevard des Philosophes</addrLine>
                                <addrLine>CH-1211 Genève</addrLine>
                            </address>
                            <authority>Theologisches Fakultät, universität Zürich</authority>
                            <availability status="restricted" n="CC-BY">
                                <licence target="https://creativecommons.org/licenses/by/4.0/"/>
                                <p>Creative Commons Attribution 4.0 CC BY 4.0</p>
                            </availability>
                            <date when="2023-10-18"/>
                        </publicationStmt>
                        <sourceDesc>
                            <msDesc>
                                <!-- corriger en fonction de lambertus  -->
                                <msIdentifier xml:id="BGE_Cti_1753_BGE_S_22877">
                                    <country>Suisse</country>
                                    <settlement>Genève</settlement>
                                    <institution>Bibliothèque de Genève</institution>
                                    <idno type="shelfmark"> BGE Cti 1753 BGE S 22877</idno>
                                </msIdentifier>
                                <msContents>
                                    <p>
                                        <biblStruct>
                                            <monogr>
                                                <!-- AUTEUR -->
                                                <author>
                                                    <persName role="exegete" ref="isni:0000000121393075">
                                                        <surname>Lambertus</surname>
                                                        <forename>Danaeus</forename>
                                                    </persName>
                                                </author>
                                                <!-- TITRE -->
                                                <title type="complete_title">In D. Pauli priorem Epistolam ad Timotheum commentarius : in quo non solum ipsius epistolae doctrina, et artificium singulorumque argumentorum loci explicantur, sed etiam vera disciplinae ecclesiasticae forma, tum ex Dei verbo, atque ex ipso Paulo, tum ex veteribus synodis repetita atque restituta est, ut legitima et apostolica regendae Dei Ecclesiae ratio et norma hodie in usum revocari possit / per Lambertum Danaeum ; accessit operi duplex index.</title> 
                                                <title type="short_title">In D. Pauli priorem Epistolam ad Timotheum commentarius</title>
                                                <imprint>
                                                    <!-- LIEU DE PUBLICATION ET IMPRIMEUR -->
                                                    <pubPlace cert="medium" ref="geonames:2659496">Genève</pubPlace>
                                                    <respStmt>
                                                        <resp>Imprimeur</resp>
                                                        <persName role="printer" ref="isni:000000043429000X">
                                                            <surname>Vignon</surname>
                                                            <forename>Eustache</forename>
                                                        </persName>
                                                    </respStmt>
                                                    <!-- DATE DE PUBLICATION -->
                                                    <date cert="low">1577</date>
                                                </imprint>
                                            </monogr>
                                        </biblStruct>
                                    </p>
                                </msContents>         
                                <physDesc>
                                    <objectDesc>
                                        <supportDesc>
                                            <support>
                                                <dim>in-8°</dim>
                                            </support>
                                        </supportDesc>
                                    </objectDesc>
                                </physDesc>
                                <additional>
                                    <!-- concernant lambert -->
                                    <surrogates>
                                        <bibl>
                                            <ref target="https://doi.org/10.3931/e-rara-6338"/>
                                            <relatedItem type="original">
                                                <ref target="#BGE Cti 1753 BGE S 22877">e-rara</ref>
                                            </relatedItem>
                                        </bibl>
                                    </surrogates>
                                    <listBibl>
                                        <bibl>
                                            <ref target="https://www.ville-ge.ch/musinfo/bd/bge/gln/notice/?no=GLN-4821">
                                                <orgName>GLN</orgName>
                                                <idno>2624</idno>
                                            </ref>
                                        </bibl>
                                    </listBibl>
                                </additional>
                            </msDesc>
                        </sourceDesc>
                    </fileDesc>
                    <encodingDesc>
                        <projectDesc>
                            <p>This digital corpus is part of the 16th Century Exegesis of Paul project, directed by Prof-Ueli Zahnd (IHR) and funded by the SNSF.</p>
                        </projectDesc>
                        <editorialDecl>
                            <correction>
                                <p>The segmentation was corrected manually and the transcription from the OCR was corrected. See the OCR construction project: <!--<ref target="lien internet du mini-memoire"/>.--> </p>
                            </correction>
                            <normalization>
                                <p>For regularisation purposes, this transcription has been standardised using a Python script<!--<ref target="lien internet vers le script python"/>.-->.</p>
                            </normalization>
                        </editorialDecl>
                        <appInfo>
                            <application ident="Kraken" version="4.1">
                                <label>Kraken</label>
                                <ptr target="https://github.com/mittagessen/kraken"/>
                            </application>
                        </appInfo>
                        <appInfo>
                            <application ident="FoNDUE" version="0.1">
                                <label>FoNDUE</label>
                                <ptr target="https://test2.fondue.unige.ch/"/>
                            </application>
                        </appInfo>
                        <classDecl>
                            <taxonomy xml:id="SegmOnto">
                                <bibl>
                                    <title>SegmOnto</title>
                                    <ptr target="https://segmonto.github.io/"/>
                                </bibl>
                                <category xml:id="SegmOntoZones"/>
                                <category xml:id="SegmOntoLines"/>
                            </taxonomy>
                        </classDecl>
                    </encodingDesc>   
                    <profileDesc>
                        <langUsage>
                            <language ident="frm">Latin from 16e centuary</language>
                        </langUsage>
                        <textClass>
                            <keywords>
                                <term type="form">theological commentaries</term>
                                <term type="segmentation_quality">gold</term>
                                <term type="transcription_quality">gold</term>
                                <term type="intermediary_reg_quality">not applicable</term>
                                <term type="contemporary_reg_quality">not applicable</term>
                                <term type="ling_annotation_quality">not applicable</term>
                            </keywords>
                        </textClass>
                    </profileDesc>
                    <revisionDesc>
                        <change when="2023-10-18" who="#FG">Création du fichier TEI P5.</change>
                    </revisionDesc> 
                </teiHeader>                
<!-- sourceDoc -->                
                <sourceDoc xml:id="transcription">
                    <xsl:for-each select="$xmlDocuments">
                        <xsl:for-each select="//alto"> 
<!-- Page -->
                            <xsl:variable name="page" select="substring-before(self::alto/Description/sourceImageInformation/fileName, '.')"/>
                            <xsl:element name="surface">
                                <!-- ID -->
                                <xsl:attribute name="xml:id">
                                    <xsl:text>f</xsl:text>
                                    <xsl:value-of select="$page"/>
                                </xsl:attribute>
                                <xsl:variable name="path-page" select="//Page/PrintSpace"/>
                                <xsl:call-template name="coordinate-with-context">
                                    <xsl:with-param name="context" select="$path-page"/>
                                </xsl:call-template>
                                <xsl:element name="graphic">
                                    <xsl:attribute name="url">
                                        <xsl:value-of select="self::alto/Description/sourceImageInformation/fileIdentifier"/>
                                        <!-- #FG : exemple d'url pour e-rara https://www.e-rara.ch/i3f/v20/165790/141,211,632,71/full/0/default.jpg 
                                        la partie intermédiaire de l'adresse est composé de 2 paire de coordonnée pour le pointage (141,211,632,71),
                                        pour obtenir la page entière remplacer ces coordonnées par 'full'-->
                                        <xsl:value-of select="concat($nma,$iiif-name,$page ,'/','full',$endfile)"/>
                                    </xsl:attribute>
                                </xsl:element>
                                <!-- pour une version minimale du SourceDoc en terme de coordonnée on peut s'arrêter là -->
<!-- Régions créer un élément zone-->
                                <xsl:for-each select="//TextBlock">
                                    <xsl:element name="zone">
                                        <xsl:attribute name="xml:id">
                                            <xsl:text>f</xsl:text>
                                            <xsl:value-of select="$page"/>
                                            <xsl:text>_</xsl:text>
                                            <xsl:value-of select="@ID"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="type">
                                            <!-- Attrapage de la valeur codée -->
                                            <xsl:variable name="type_zone">
                                                <xsl:value-of select="@TAGREFS"/>
                                            </xsl:variable>
                                            <!-- Recherche de la véritable valeur exprimée : attribue son nom à la zone de texte
                                            exemple : <zone xml:id="f2012971_block_2" type="MainZone"/>-->
                                            <xsl:variable name="type_zone_valeur">
                                                <xsl:value-of
                                                    select="//OtherTag[@ID = $type_zone]/@LABEL"/>
                                            </xsl:variable>
                                            <xsl:value-of select="$type_zone_valeur"/>
                                        </xsl:attribute>
                                        <!--récupère le numéro de la zone
                                           exemple : <zone xml:id="f2012970_block_2" type="RunningTitleZone2 -->
                                        <xsl:call-template name="n-attribute"/>
                                        <xsl:call-template name="cordinate-only"/>
                                        <xsl:call-template name="point-pair"/>
                                        <xsl:call-template name="build-source">
                                            <xsl:with-param name="endfile" select="$endfile"/>
                                        </xsl:call-template>
<!-- Lines -->
                                        <xsl:for-each select="TextLine">
                                            <xsl:element name="zone">
                                                <!-- récupère l'id de chaque ligne
                                                exemple : <zone xml:id="f2012960_eSc_line_402ee15e"/> -->
                                                <xsl:attribute name="xml:id">
                                                    <xsl:text>f</xsl:text>
                                                    <xsl:value-of select="$page"/>
                                                    <xsl:text>_</xsl:text>
                                                    <xsl:value-of select="@ID"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="type">
                                                    <xsl:text>segmontoLine</xsl:text>
                                                </xsl:attribute>
                                                <xsl:attribute name="type">
                                                    <!-- Attrapage de la valeur -->
                                                    <xsl:variable name="type_zone">
                                                        <xsl:value-of select="@TAGREFS"/>
                                                    </xsl:variable>
                                                    <!-- Recherche de la véritable valeur -->
                                                    <xsl:variable name="type_zone_valeur">
                                                        <xsl:value-of select="//OtherTag[@ID = $type_zone]/@LABEL"/>
                                                    </xsl:variable>
                                                    <xsl:value-of select="$type_zone_valeur"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="n-attribute"/>
                                                <xsl:call-template name="cordinate-only"/>
                                                <xsl:call-template name="point-pair"/>
                                                <xsl:call-template name="build-source">
                                                    <xsl:with-param name="endfile" select="$endfile"/>
                                                </xsl:call-template>
<!-- Baseline -->
                                                <xsl:element name="path">
                                                    <xsl:variable name="nbaseline">
                                                        <xsl:number level="single" count="." format="1"/>
                                                    </xsl:variable>
                                                    <xsl:attribute name="n">
                                                        <xsl:value-of select="$nbaseline"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="xml:id">
                                                        <xsl:value-of select="concat('f',$page,'_',@ID, '_baseline_', $nbaseline)"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="type">
                                                        <xsl:text>baseline</xsl:text>
                                                    </xsl:attribute>
                                                    <xsl:call-template name="point-pair"/>
                                                </xsl:element>
<!-- Transcription -->
                                                <xsl:element name="line">
                                                    <xsl:variable name="nline">
                                                        <xsl:number level="single" count="." format="1"/>
                                                    </xsl:variable>
                                                    <xsl:attribute name="xml:id">
                                                        <xsl:value-of
                                                            select="concat('f',$page,'_',@ID, '_ligne_', $nline)"/>
                                                    </xsl:attribute>
                                                    <xsl:value-of select="String/@CONTENT"/>
                                                </xsl:element>
                                            </xsl:element>
                                        </xsl:for-each>
                                    </xsl:element>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:for-each>
                </sourceDoc>
                
                <xsl:element name="text">
                    <xsl:element name="body">
                        <xsl:element name="p"/>
                    </xsl:element>
                </xsl:element>
                
            </TEI>
        </xsl:template>
           
</xsl:stylesheet>
