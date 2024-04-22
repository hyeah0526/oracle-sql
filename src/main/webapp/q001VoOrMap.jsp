<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!-- 컨트롤러Controller -->
<%
	// DAO호출로 모델(데이터) 반환
	ArrayList<Dept> deptList = DeptDAO.selectDeptList();
	ArrayList<Emp> empList = EmpDAO.selectEmpList();
	ArrayList<HashMap<String, Object>> deptOnOffList = DeptDAO.selectDeptOnoffList();
	ArrayList<HashMap<String, Object>> empAndDeptList = EmpDAO.selectEmpAndDeptList();
%>

<!-- 뷰View -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>q001VoOrMap - Query예제 001</title>
</head>
<body>
	<h1>Dept List</h1>
	<table>
		<tr>
			<th>deptno</th>
			<th>dname</th>
			<th>loc</th>
		</tr>
		<%
			for(Dept d : deptList){
		%>
			<tr>
				<td><%=d.getDeptNo()%></td>
				<td><%=d.getDname()%></td>
				<td><%=d.getLoc()%></td>
			</tr>
		<%
			}
		%>
	</table>
	
	<h1>Emp List</h1>
	<table>
		<tr>
			<th>EmpNo</th>
			<th>ename</th>
			<th>loc</th>
		</tr>
		<%
			for(Emp e : empList){
		%>
			<tr>
				<td><%=e.getEmpNo()%></td>
				<td><%=e.getEname()%></td>
				<td><%=e.getSal()%></td>
			</tr>
		<%
			}
		%>
	</table>
	
	<h1>Dept + onOff값이 추가된 List</h1>
	<table>
		<tr>
			<th>EmpNo</th>
			<th>ename</th>
			<th>loc</th>
			<th>onOff</th>
		</tr>
		<%
			// map단점 : 1. 형변환이 필요 2.IDE의 자동완성기능 사용불가
			for(HashMap<String, Object> don : deptOnOffList){
		%>
			<tr>
				<td><%=(Integer)don.get("deptNo")%></td>
				<td><%=(String)don.get("dname")%></td>
				<td><%=(String)don.get("loc")%></td>
				<td><%=(String)don.get("onOff")%></td>
			</tr>
		<%
			}
		%>
	</table>
	
	<h1>Emp INNER JOIN Dept List</h1>
	<table>
		<tr>
			<th>EmpNo</th>
			<th>ename</th>
			<th>deptNo</th>
			<th>dname</th>
		</tr>
		<%
			// map단점 : 1. 형변환이 필요 2.IDE의 자동완성기능 사용불가
			for(HashMap<String, Object> ed : empAndDeptList){
		%>
			<tr>
				<td><%=(Integer)ed.get("empNo")%></td>
				<td><%=(String)ed.get("ename")%></td>
				<td><%=(Integer)ed.get("deptNo")%></td>
				<td><%=(String)ed.get("dname")%></td>
			</tr>
		<%
			}
		%>
	</table>
</body>
</html>