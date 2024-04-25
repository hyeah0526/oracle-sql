<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<!-- 컨트롤러C -->
<%
	// 어떤 컬럼으로 정렬할건지 
	String col = request.getParameter("col");
	//System.out.println(col + " <-- col q005OrderBy.jsp param");
	
	// asc오름차순 / desc내림차순 값 가져오기
	String sort = request.getParameter("sort");
	//System.out.println(sort + " <-- sort q005OrderBy.jsp param");
	
	// DAO(모델)를 호출 후 모델을 반환
	ArrayList<Emp> list = EmpDAO.selectEmpListSort(col, sort);
	System.out.println(list.size()+" <-- list.size() q005OrderBy.jsp ");
%>

<!-- 뷰V -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<table border="1" style="text-align: center;">
		<tr>
			<th>
				empno
				<a href="./q005OrderBy.jsp?col=empno&sort=asc">[오름차순]</a>
				<a href="./q005OrderBy.jsp?col=empno&sort=desc">[내림차순]</a>
			</th>
			<th>
				ename
				<a href="./q005OrderBy.jsp?col=ename&sort=asc"">[오름차순]</a>
				<a href="./q005OrderBy.jsp?col=ename&sort=desc">[내림차순]</a>
			</th>
		</tr>
		<%
			for(Emp e : list){
		%>
				<tr>
					<td><%=(Integer)e.getEmpNo()%></td>
					<td><%=(String)e.getEname()%></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>