<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.EmpDAO"%>
<%@ page import="java.util.*"%>
<!-- 컨트롤러C -->
<%
	// DAO - selectEmpMgr
	ArrayList<HashMap<String, Object>> list = EmpDAO.selectEmpMgr();
%>

<!-- 뷰V -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>q007SelfJoin.jsp</title>
</head>
<body>
	<h1>Self Join</h1>
	<table border="1">
		<tr>
			<th>empno</th>
			<th>ename</th>
			<th>grade</th>
			<th>mgrName</th>
			<th>mgrGrade</th>
		</tr>
		<%
			for(HashMap<String, Object> e : list){
		%>
				<tr>
					<td><%=(Integer)e.get("empno")%></td>
					<td><%=(String)e.get("ename")%></td>
					<td>
						<%
							// garde 수만큼 별(&#127775;) 찍어주기
							for(int i=0; i<(Integer)e.get("grade"); i++){
						%>
								&#127775;
						<%
							}
						%>
					</td>
					<td><%=(String)e.get("mgrName")%></td>
					<td>
						<%
							// mgrGrade수만큼 문자열로 하트(&#128151;)찍어주기
							String heart = "&#128151";
							String mgrGrade = heart.repeat((Integer)e.get("mgrGrade"));
						%>
						<%=mgrGrade%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	
</body>
</html>