<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.EmpDAO"%>
<%@ page import="java.util.*"%>
<!-- 컨트롤러C -->
<%
	// DAO - selectEmpSalStats
	ArrayList<HashMap<String, Integer>> list = EmpDAO.selectEmpSalStats();
%>

<!-- 뷰V -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>q006groupBy.jsp</title>
</head>
<body>
	<h1>등급별 Sal통계</h1>
	<table border="1">
		<tr>
			<th>grade</th>
			<th>count</th>
			<th>sum</th>
			<th>avg</th>
			<th>max</th>
			<th>min</th>
		</tr>
			<%
				for(HashMap<String, Integer> m : list){
			%>
					<tr>
						<td>
							<%
								// garde 수만큼 별(&#127775;) 찍어주기
								for(int i=0; i<(Integer)m.get("grade"); i++){
							%>
										&#127775;
							<%
								}
							%>
						</td>
						<td>
							<%
								// count수만큼 문자열로 하트(&#128151;)찍어주기
								String heart = "&#128151";
								String count = heart.repeat((Integer)m.get("count"));
							%>
							<%=count%>
						</td>
						<td><%=(Integer)m.get("sum")%></td>
						<td><%=(Integer)m.get("avg")%></td>
						<td><%=(Integer)m.get("max")%></td>
						<td><%=(Integer)m.get("min")%></td>
					</tr>
			<%
				}
			%>
	</table>
</body>
</html>