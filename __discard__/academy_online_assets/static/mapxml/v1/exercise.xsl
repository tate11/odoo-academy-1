<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="stabilisers" select="//notebook/@stabilisers"/>
    
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                
                <title>
                    <xsl:value-of select="notebook/name"/>
                </title>
                
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
                    integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
                    crossorigin="anonymous"/>
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
                    integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
                    crossorigin="anonymous"/>
                <link rel="stylesheet" href="http://guanaco:8069/academy_online_assets/static/mapxml/v1/notebook.css"/>
                
            </head>
            
            <body>
                
                <div class="container">
                    <xsl:for-each select="notebook/activity">
                        <xsl:choose>
                            <xsl:when test="preview">
                                <img class="preview" src="{preview}"></img>
                            </xsl:when>
                        </xsl:choose>
                        <section>
                            <header>
                                <h2>
                                    <xsl:value-of select="name"/>
                                </h2>
                            </header>
                            <xsl:for-each select="block">
                                <article>
                                    <xsl:choose>
                                        <xsl:when test="name">
                                            <header>
                                                <h3>
                                                    <xsl:value-of select="name"/>
                                                </h3>
                                            </header>
                                        </xsl:when>
                                    </xsl:choose>
                                    <div class="article-content">
                                        <xsl:for-each select="division">
                                            <div class="division">
                                                <xsl:choose>
                                                    <xsl:when test="name">
                                                        <h4>
                                                            <xsl:value-of select="name"/>
                                                        </h4>
                                                    </xsl:when>
                                                </xsl:choose>
                                                <xsl:for-each select="target">
                                                    <xsl:choose>
                                                        <xsl:when test="name">
                                                            <div class="target">
                                                                <strong><xsl:value-of select="name"/>:</strong><xsl:text> </xsl:text>
                                                                '<span> <xsl:value-of select="value" disable-output-escaping="yes" /></span>'.
                                                            </div>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <div>
                                                                <xsl:value-of select="value" disable-output-escaping="yes"/>
                                                            </div>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:for-each>
                                                <xsl:for-each select="statement">
                                                    <!-- <xsl:sort select="name" /> -->
                                                    <xsl:if test="default = 'Falso'">
                                                        <div class="row">
                                                            <xsl:choose>
                                                                <xsl:when test="$stabilisers='true' and description and not(string-length(description) > 12)">
                                                                    <div class="col-xs-10 statement {@class}">
                                                                        <xsl:apply-templates select=".">
                                                                            <!-- <xsl:sort select="name" /> -->
                                                                        </xsl:apply-templates>
                                                                    </div>
                                                                    <div class="col-xs-2 statement text-right">
                                                                        <small class="label label-info"><xsl:value-of select="description"/></small>
                                                                    </div>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <div class="col-xs-12 statement {@class}">
                                                                        <xsl:apply-templates select=".">
                                                                            <!-- <xsl:sort select="name" /> -->
                                                                        </xsl:apply-templates>
                                                                    </div>
                                                                    <xsl:if test="$stabilisers and description">
                                                                        <div class="col-xs-12">
                                                                            <div class="" style="word-break: break-all;">
                                                                                <small class="label label-info"><xsl:value-of select="description"/></small>
                                                                            </div>
                                                                        </div>
                                                                    </xsl:if>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </div>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </div>
                                        </xsl:for-each>
                                    </div>
                                </article>
                            </xsl:for-each>
                        </section>
                        
                    </xsl:for-each>
                    
                    <section style="display: none">
                        <header>
                            <h2>Estadísdicas</h2>
                        </header>
                        <article>
                            <header>
                                <h3>Instrucciones</h3>
                            </header>
                            <div class="article-content">
                                <div>
                                    <strong>Mecanografía: </strong>
                                    <span><xsl:value-of
                                        select="string-length(//target[@class = 'typing']/value)"
                                    /></span> caracteres. </div>
                                <div>
                                    <strong>Totales: </strong>
                                    <span><xsl:value-of select="count(//statement[default='Falso' and not(value/statement)])"/></span>
                                    instrucciones.
                                </div>
                                
                                <div>
                                    <strong>Word: </strong>
                                    <span><xsl:value-of select="count(//statement[default='Falso' and not(value/statement)]) - count(//statement[default='Falso' and not(value/statement) and @class='list'])"/></span>
                                    instrucciones.
                                </div>
                                
                                <div>
                                    <strong>Excel: </strong>
                                    <span><xsl:value-of select="count(//statement[default='Falso' and @class='list'])"/></span>
                                    instrucciones.
                                </div>
                                
                                <div>
                                    <strong>Instrucción 185 en </strong>
                                    <strong>bloque </strong>«<xsl:value-of select="(//statement[default='Falso' and not(value/statement)])[185]/ancestor-or-self::block/name"/>»
                                    <xsl:choose>
                                        <xsl:when test="(//statement[default='Falso' and not(value/statement)])[185]/ancestor-or-self::division/name">
                                            <strong>, división </strong>«<xsl:value-of select="(//statement[default='Falso' and not(value/statement)])[185]/ancestor-or-self::division/name"/>»
                                        </xsl:when>
                                    </xsl:choose>
                                    <strong>, instrución </strong>«<xsl:value-of select="(//statement[default='Falso' and not(value/statement)])[185]/name"/>: <xsl:value-of select="(//statement[default='Falso' and not(value/statement)])[185]/value"/>».
                                </div>
                                
                            </div>
                        </article>
                    </section>
                </div>
                <!-- container -->
                
                <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"/>
                <!-- Include all compiled plugins (below), or include individual files as needed -->
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="statement" name="statement">
        <span>
            <xsl:choose>
                <xsl:when test="name">
                    <xsl:choose>
                        <xsl:when test="@class">
                            <xsl:if test="not(@class='list')">
                                <strong><xsl:value-of select="name"/>: </strong>
                            </xsl:if>
                            <xsl:if test="@class = 'list' and not(value/statement)">
                                <strong><xsl:value-of select="name"/> </strong>
                            </xsl:if>
                            <xsl:if test="@class = 'list' and value/statement">
                                <strong><xsl:value-of select="name"/>&#160;</strong>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <strong><xsl:value-of select="name"/>: </strong>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="not(@class='list') and value/statement">
                    <xsl:choose>
                        <xsl:when test="name">(</xsl:when>
                    </xsl:choose>
                    <xsl:for-each select="value/statement">
                        <!-- <xsl:sort select="name" /> -->
                        <xsl:if test="default = 'Falso'">
                            <xsl:apply-templates select=".">
                                <xsl:with-param name="islast" select="position() = last()"/>
                                <!-- <xsl:sort select="name" /> -->
                            </xsl:apply-templates>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:choose>
                        <xsl:when test="name">) </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="@class = 'list' and value/statement">
                    <span><xsl:value-of select="value/text()"/>:</span>
                    <span class="ul">
                        <xsl:for-each select="value/statement">
                            <span class="li"><strong><xsl:value-of select="name"/></strong>&#160;<span><xsl:value-of select="value"/></span>.</span>
                        </xsl:for-each>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <span>
                        <xsl:value-of select="value" disable-output-escaping="yes" />. </span>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    
</xsl:stylesheet>
