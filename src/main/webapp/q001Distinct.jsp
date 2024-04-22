<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ArrayList<Integer> list = EmpDAO.selectDeptNoList();	

	ArrayList<HashMap<String, Integer>> group = EmpDAO.selectDeptNoCnt();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>DISTINCT</title>
</head>
<body>
	<h1>DISTINCT를 사용</h1>
	<select name="deptNo">
		<option value="">:::선택:::</option>
		<%
			for(Integer i : list){
		%>
			<option value="<%=i%>"><%=i%></option>		
		<%
			}
		%>
	</select>
	
	<h1>DISTINCT대신 GROUP BY를 사용해야만하는 경우</h1>
	<select>
		<option value="">:::선택:::</option>
	<%
			for(HashMap g : group){
	%>
				<option value='<%=(Integer)g.get("deptNo")%>'>
					<%=(Integer)g.get("cnt")%> / 
					<%=(Integer)g.get("deptNo")%>
				</option>
	<%
		}
	%>
	</select>
</body>
</html>