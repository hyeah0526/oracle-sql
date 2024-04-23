<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	ArrayList<Emp> list = null;

	String[] ck = request.getParameterValues("ck");
	if(ck == null){
		// null이면 그냥 ck를 출력하여 null확인
		System.out.println(ck + " <-- ck");
	}else{
		// ck가 null이 아니면 그 길이를 출력 (몇개 선택했는지)
		System.out.println(ck.length + " <-- ck.length");
		
		// ck의 String문자열배열을 -> integer로 형변환해줘야함
		// 각각의 문자열을 ckList에 다시 integer.parseInt로 형변환하여 넣어줄 것 
		ArrayList<Integer> ckList = new ArrayList<>();
		for(String s : ck){
			ckList.add(Integer.parseInt(s));
		}
		
		list = EmpDAO.selectEmpListByGrade(ckList);
		System.out.println(list.size() + " <-- 결과셋행사이즈 list.size()");
	}
%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>q004WhereIn.jsp</title>
</head>
<body>
   <h1>EMP GRADE 검색</h1>
   <form action="./q004WhereIn.jsp" method="post">
      GRADE : 
      <%
         for(int i=1; i<6; i=i+1) {
      %>
            <input name="ck" type="checkbox" value="<%=i%>"><%=i%>
      <%      
         }
      %>
      <br>
      <button type="submit">검색</button>
   </form>
   
   <hr>
   
   <h1>결과 View</h1>
   <%
   	if(ck == null){
   		return; //ck가 null이면 아무것도 출력하지 않고 끝내기
   	}
   %>
   <table>
		<tr>
			<th>ename</th>
			<th>grade</th>
		</tr>
		<%
			for(Emp e : list){
		%>
				<tr>
					<td><%=(String)e.getEname()%></td>
					<td><%=(Integer)e.getGrade()%></td>
				</tr>
		<%
			}
		%>
   </table>
</body>
</html>