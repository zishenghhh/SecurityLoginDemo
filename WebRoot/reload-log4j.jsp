<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.log4j.xml.DOMConfigurator"%>
<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Reload Log4j XML File</title>
</head>
<body>
<%
DOMConfigurator.configure(this.getClass().getResource("/log4j.xml"));
Logger log   = LoggerFactory.getLogger(org.slf4j.Logger.class);
log.debug("DEBUG");
log.info("INFO");
log.warn("WARN");
log.error("ERROR");
%>
Reload Log4j XML File Successfully!
</body>
</html>