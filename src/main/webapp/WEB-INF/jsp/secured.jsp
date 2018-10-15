<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="org.springframework.security.saml.SAMLCredential"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="org.springframework.security.core.Authentication"%>
<%@ page import="org.opensaml.saml2.core.Attribute" %>
<%@ page import="org.springframework.security.saml.util.SAMLUtil" %>
<%@ page import="org.opensaml.xml.util.XMLHelper" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SAMLTEST1</title>
</head>
<body>
	<h1>SAMLTEST1</h1>
	<h2>${message}</h2>
	<br>
	<%
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        SAMLCredential credential = (SAMLCredential) authentication.getCredentials();
        pageContext.setAttribute("authentication", authentication);
        pageContext.setAttribute("credential", credential);
        pageContext.setAttribute("assertion", XMLHelper.nodeToString(SAMLUtil.marshallMessage(credential.getAuthenticationAssertion())));
	%>
	<table>
		<tr>
			<td colspan="2"><h3>General information</h3></td>
		</tr>
		<tr>
			<td width="200"><strong>Name:</strong></td>
			<td><c:out value="${username}" /></td>
		</tr>
		<tr>
			<td><strong>Principal:</strong></td>
			<td><c:out value="${authprincipal}" /></td>
		</tr>
		<tr>
			<td><strong>Name ID:</strong></td>
			<td><c:out value="${crednameidvalue}" /></td>
		</tr>
		<tr>
			<td><strong>Name ID format:</strong></td>
			<td><c:out value="${crednameidformat}" /></td>
		</tr>
		<tr>
			<td><strong>IDP:</strong></td>
			<td><c:out value="${credauthissuerval}" /></td>
		</tr>
		<tr>
			<td><strong>Assertion issue time:</strong></td>
			<td><c:out value="${credauthissueinstant}" /></td>
		</tr>
	</table>
	<br>
	<table>
        <tr>
            <td colspan="2"><h3>Principal's SAML attributes</h3></td>
        </tr>
        <c:forEach var="attribute" items="${credential.attributes}">
            <tr>
                <td width="400">
                    <strong><c:out value="${attribute.name}"/></strong><c:if test="${not empty attribute.friendlyName}"> (<c:out value="${attribute.friendlyName}"/>)</c:if>
                </td>
                <td>
                    <%
                        Attribute a = (Attribute) pageContext.getAttribute("attribute");
                        String[] attributeValues = credential.getAttributeAsStringArray(a.getName());
                        pageContext.setAttribute("attributeValues", attributeValues);
                    %>
                    <c:forEach var="attributeValue" items="${attributeValues}">
                        <c:out value="${attributeValue}"/>&nbsp;
                    </c:forEach>
                </td>
            </tr>
        </c:forEach>
    </table>
	<br>
	<a href="./home">Home</a>
	<br>
	<br>
	<table>
		<tr>
			<td>
				<form class="left" action="<c:url value="/saml/logout"/>"
					method="get">
					<input type="submit" value="Global Logout" class="button" />
				</form>
			</td>
			<td>
				<form class="left" action="<c:url value="/saml/logout"/>"
					method="get">
					<input type="hidden" name="local" value="true" /> <input
						type="submit" value="Local Logout" class="button" />
				</form>
			</td>
		</tr>
	</table>
</body>
</html>