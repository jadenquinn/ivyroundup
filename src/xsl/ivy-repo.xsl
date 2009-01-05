<?xml version="1.0" encoding="ISO-8859-1"?>

<!--
    Copyright 2008 Archie L. Cobbs.

    Licensed under the Apache License, Version 2.0 (the "License"); you may
    not use this file except in compliance with the License. You may obtain
    a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
    License for the specific language governing permissions and limitations
    under the License.
-->

<!-- $Id$ -->
<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  version="1.0">

    <xsl:output encoding="UTF-8" method="xml" indent="no" media-type="text/xml"/>

    <xsl:variable name="svnrevision" select="'$Id$'"/>
    <xsl:variable name="svnviewbase" select="'http://code.google.com/p/ivyroundup/source/browse@SVNROOTPATH@/src/modules'"/>

    <xsl:param name="organisation"/>
    <xsl:param name="module"/>
    <xsl:param name="revision"/>

    <xsl:template match="/">
        <xsl:copy>
            <xsl:value-of select="'&#10;'"/>
            <!-- Add stylesheet reference -->
            <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="../../../../xsl/ivy-doc.xsl"</xsl:processing-instruction>
            <xsl:value-of select="'&#10;'"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/ivy-module">

        <!-- Various style and consistency checks -->
        <xsl:if test="@version">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'&quot;version&quot; attribute is auto-populated; do not include'"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="not(starts-with(@rev, '$Id'))">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'tag should have a &quot;rev&quot; attribute containing &quot;$Id$&quot;'"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:value-of select="'&#10;'"/>
        <xsl:comment> GENERATED FILE - DO NOT EDIT </xsl:comment>
        <xsl:value-of select="'&#10;'"/>
        <xsl:comment> Generated by <xsl:value-of select="concat($svnrevision, ' ')"/></xsl:comment>
        <xsl:value-of select="'&#10;'"/>
        <xsl:copy>
            <!-- Add version and xsi:noNamespaceSchemaLocation attributes -->
            <xsl:attribute name="version">1.3</xsl:attribute>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">../../../../xsd/ivy.xsd</xsl:attribute>
            <xsl:apply-templates select="@*[name() != 'rev']|node()"/>
        </xsl:copy>
        <xsl:value-of select="'&#10;'"/>
    </xsl:template>

    <xsl:template match="/ivy-module/info">

        <!-- Various style and consistency checks -->
        <xsl:if test="@organisation or @module or @revision">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'&quot;organisation&quot;, &quot;module&quot;, and &quot;status&quot; are auto-populated; do not include'"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="@status = 'release'">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'status=&quot;release&quot; is the default; do not include'"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="translate(@publication, '0123456789', '0000000000') != '00000000000000'">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'valid 14-digit &quot;publication&quot; attribute is required in &lt;info&gt; tag'"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:copy>
            <!-- Auto-insert organisation, module, and revision attributes -->
            <xsl:attribute name="organisation">
                <xsl:value-of select="$organisation"/>
            </xsl:attribute>
            <xsl:attribute name="module">
                <xsl:value-of select="$module"/>
            </xsl:attribute>
            <xsl:attribute name="revision">
                <xsl:value-of select="$revision"/>
            </xsl:attribute>
            <xsl:if test="not(@status)">
                <xsl:attribute name="status">release</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="@*"/>
            <xsl:value-of select="'&#10;        '"/>
            <xsl:if test="license">
                <xsl:apply-templates select="license"/>
                <xsl:value-of select="'&#10;        '"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="ivyauthor">
                    <xsl:apply-templates select="ivyauthor"/>
                    <xsl:value-of select="'&#10;        '"/>
                </xsl:when>
                <xsl:otherwise>
                    <!--
                        Set <ivyauthor> based on SVN revision string and
                        set hyperlink to point to the SVN web interface.
                        -->
                    <ivyauthor>
                        <xsl:attribute name="name">
                            <xsl:choose>
                                <xsl:when test="/ivy-module/@rev">
                                    <xsl:value-of select="/ivy-module/@rev"/>
                                </xsl:when>
                                <xsl:otherwise>Ivy RoundUp Repository</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:attribute name="url">
                            <xsl:value-of select="concat($svnviewbase, '/', $organisation, '/', $module, '/', $revision, '/')"/>
                        </xsl:attribute>
                    </ivyauthor>
                    <xsl:value-of select="'&#10;        '"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Add <repository> tag pointing to Ivy RoundUp -->
            <repository name="ivyroundup" url="http://ivyroundup.googlecode.com/" ivys="true"
              pattern="http://ivyroundup.googlecode.com/svn/trunk/repo/modules/[organisation]/[module]/[revision]/ivy.xml"/>
            <xsl:value-of select="'&#10;        '"/>
            <xsl:apply-templates select="description"/>
            <xsl:value-of select="'&#10;    '"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/ivy-module/configurations">
        <!-- Various style and consistency checks -->
        <xsl:if test="count(conf) = 0">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'empty &lt;configurations&gt; tag'"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="not(conf[@name = 'default'])">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'no &quot;default&quot; &lt;configuration&gt; defined'"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/ivy-module/configurations/configuration">
        <!-- Various style and consistency checks -->
        <xsl:if test="@name != 'default' and not(@description)">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'non-default &lt;configuration&gt; tags must have &quot;description&quot; attributes'"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="/ivy-module/dependencies">
        <!-- Various style and consistency checks -->
        <xsl:if test="count(dependency) = 0">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'empty &lt;dependencies&gt; tag'"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/ivy-module/dependencies/dependency">
        <!-- Various style and consistency checks -->
        <xsl:if test="not(@org) or not(@name) or not(@rev) or not(@conf)">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'&quot;org&quot;, &quot;name&quot;, &quot;rev&quot;, and &quot;conf&quot; attributes are required in &lt;dependency&gt; tags'"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Check comments -->
    <xsl:template match="comment()">

        <!-- Detect "YOUR NAME HERE" -->
        <xsl:if test="contains(., 'YOUR NAME HERE')">
            <xsl:call-template name="error">
                <xsl:with-param name="msg" select="'put your own name in the copyright message'"/>
            </xsl:call-template>
        </xsl:if>

        <!-- Warn about "XXX" and "TODO" markers -->
        <xsl:if test="contains(., 'XXX') or contains(., 'TODO')">
            <xsl:call-template name="warning">
                <xsl:with-param name="msg" select="'comment with &quot;XXX&quot; and/or &quot;TODO&quot; marker found'"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Copy everything else exactly -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Warning and error templates -->
    <xsl:template name="error">
        <xsl:param name="msg"/>
        <xsl:call-template name="message">
            <xsl:with-param name="msg" select="$msg"/>
            <xsl:with-param name="kind" select="'ERROR'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="warning">
        <xsl:param name="msg"/>
        <xsl:call-template name="message">
            <xsl:with-param name="msg" select="$msg"/>
            <xsl:with-param name="kind" select="'WARNING'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="message">
        <xsl:param name="msg"/>
        <xsl:param name="kind"/>
        <xsl:message>
            <xsl:if test="$kind = 'ERROR'">&#10;**********************************************************************************</xsl:if>
            <xsl:value-of select="concat('&#10;*** ', $kind, ': ', $organisation, '/', $module, '/', $revision, '/ivy.xml: ', $msg)"/>
            <xsl:if test="$kind = 'ERROR'">&#10;**********************************************************************************</xsl:if>
        </xsl:message>
    </xsl:template>

</xsl:transform>
