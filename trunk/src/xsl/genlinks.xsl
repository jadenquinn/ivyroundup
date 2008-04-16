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
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output encoding="ISO-8859-1" method="text" indent="no"/>

    <xsl:template match="/modules">
        <xsl:value-of select="'#/bin/sh&#10;'"/>
        <xsl:value-of select="'# GENERATED FILE - DO NOT EDIT&#10;'"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="/modules/org/alias">
        <xsl:value-of select="concat('ln -s ', ../@name, ' repo/modules/', @name, '&#10;')"/>
    </xsl:template>

    <xsl:template match="/modules/org/mod/alias">
        <xsl:value-of select="concat('ln -s ', ../../@name, ' repo/modules/', ../@name, '/', @name, '&#10;')"/>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:transform>
