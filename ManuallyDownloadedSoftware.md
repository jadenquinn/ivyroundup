Some software in Ivy RoundUp cannot be downloaded directly from the Internet, due to the requirement that you must click to accept a license, browser cookie tracking, or whatever.

For these cases, the `packager.xml` files will look for the archive instead in `${java.io.tmpdir}.` On UNIX systems, this is normally `/tmp`. You must download the archive files manually and put them there.

At the time of this writing, the following modules fall into this category. Note many of these can be found by starting from [this page](http://www.oracle.com/technetwork/java/javaee/tech/index.html) and/or [this page](http://www.oracle.com/technetwork/indexes/downloads/sun-az-index-095901.html).

| **Module** | **Version** | **File(s) and Link** | **Notes** |
|:-----------|:------------|:---------------------|:----------|
| jmx        | 1.2.1       | [jmx-1\_2\_1-ri.zip](http://www.oracle.com/technetwork/java/javase/tech/download-jsp-141676.html) | Download JMX 1.2.1 Reference Implementation |
| jmxremote  | 1.0.1\_04   | [jmxremote-1\_0\_1-ri-bin-b58.zip](http://java.sun.com/javase/technologies/core/mntr-mgmt/javamanagement/download.jsp) |           |
| j2ee\_management | 1.0         | [j2ee\_management-1\_0-fr-class.zip](http://java.sun.com/j2ee/tools/management/downloads/index.html) |           |
| javamail   | 1.4.1       | [javamail-1\_4\_1.zip](http://java.sun.com/products/javamail/downloads/index.html) |           |
| jms        | 1.1         | [jms-1\_1-fr-apidocs.zip](http://download.oracle.com/otndocs/jcp/7542-jms-1.1-fr-doc-oth-JSpec/) |           |
| sjsxp      | 1.0.1, 1.0.2 | [sjsxp-1\_0\_1/sjsxp.jar](https://sjsxp.dev.java.net/#downloads)<br /> [sjsxp-1\_0\_2/sjsxp.jar](https://sjsxp.dev.java.net/#downloads)| Click on "SJSXP 1.0.1" and "SJSXP 1.0.2", download files into `${java.io.tmpdir`}, then run `java -cp . sjsxp_101` and `java -cp . sjsxp_102` to extract the archives, resulting in directories `sjsxp-1_0_1` and `sjsxp-1_0_2`. |
| ojdbc      | All         | [ojdbc\*.jar, ons.jar, orai18n.jar, and javadoc.zip](http://www.oracle.com/technology/software/tech/java/sqlj_jdbc/htdocs/jdbc_10201.html) | Accept License Agreement, then click on download links. **NOTE:** each version's JARs must be placed in `${java.io.tmpdir}/ojdbc/<version>/` |
| jnlp       | 1.5, 6.0    | jardiff.jar, jnlp.jar, jnlp-servlet.jar | Extract from [J2SE Demos and Samples](http://www.oracle.com/technetwork/java/javase/) in `sample/jnlp/servlet`. Note JDK 7 version no longer requires manual download! |
| jacc       | 1.0         | [jacc-1\_0-fr-class.zip](http://java.sun.com/j2ee/javaacc/) |           |
| jaxb       | 1.0-2.2.4.u1 | [JAXB2\_YYYYMMDD.jar](http://jaxb.java.net/) | Download and execute (via `java -jar JAXB2_YYMMDD.jar`) the JAR, then move the the `jaxb-ri-YYYYMMDD/lib/` subdirectory to `${java.io.tmpdir}/jaxb/<version>` |
| ejb        | 3.0         | [ejb-3\_0-fr-api.zip](http://java.sun.com/products/ejb/docs.html) | Click "Download" button for the class files and documentation, Accept License Agreement, then click on download links |
| IBM thinclient | All         | [com.ibm.xml.thinclient\_X.X.X.X.zip, xml\_and\_import\_repositories.zip](http://www-01.ibm.com/software/webservers/appserv/was/featurepacks/xml/instopt/)| Click "Download the compressed file containing the thin client" link at the bottom to download `com.ibm.xml.thinclient_X.X.X.X.zip`. Go back then click "Download for local installation using IBM Installation Manager" to download `xml_and_import_repositories.zip`. In both cases, choose HTTP download. |
| Some Vaadin plugins (e.g., [icepush](http://vaadin.com/directory#addon/icepush), [vaadin-jpacontainer](http://vaadin.com/directory#addon/vaadin-jpacontainer)) | All         | [Vaadin Add-On Directory](http://vaadin.com/directory) | Registration required |
| madura-rules | All         | [madura-rules-X.Y.zip](http://code.google.com/p/madura-rules/downloads/list) |           |
| svnant     | 1.2.1, 1.3.0 | [svnant​-1.2.1.zip](http://subclipse.tig​ris.org/files/docume​nts/906/43359/svnant​-1.2.1.zip) [svnant​-1.3.0.zip](http://subclipse.tig​ris.org/files/docume​nts/906/46267/svnant​-1.3.0.zip) | Endless redirection loop if your browser does not allow cookies. Must download manually, since Ant's get task does not allow cookies. |