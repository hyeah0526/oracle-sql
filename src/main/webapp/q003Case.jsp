<%@page import="dao.DeptDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ArrayList<HashMap<String, String>> caseList = DeptDAO.selectJobCaseList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Case</title>
</head>
<body>
	<h1>select Job Case List</h1>
	<table>
		<tr>
			<th>ename</th>
			<th>job</th>
			<th>color</th>
		</tr>
	<%
		for(HashMap g : caseList){
	%>
		<tr>
			<td><%=(String)g.get("ename")%></td>
			<td><%=(String)g.get("job")%></td>
			<td><%=(String)g.get("color")%></td>
		</tr>
	<%
		}
	%>
	</table>
</body>
</html>