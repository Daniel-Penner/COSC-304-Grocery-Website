<%
	boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;

	if (!authenticated)
	{   
		response.sendRedirect("register.jsp");
	}
%>
