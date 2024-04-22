package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.spi.DirStateFactory.Result;

import vo.Dept;

public class DeptDAO {
	// q003Case.jsp
	public static ArrayList<HashMap<String, String>> selectJobCaseList() throws Exception{
		ArrayList<HashMap<String, String>> list = new ArrayList<>();
		
		String sql = "SELECT ename,"
				+ "        job,"
				+ "        CASE"
				+ "        WHEN job = 'PRESIDENT' Then '빨강'"
				+ "        WHEN job = 'MANAGER' THEN '주황'"
				+ "        WHEN job = 'ANALYST' THEN '노랑'"
				+ "        WHEN job = 'CLERK' THEN '초록'"
				+ "        ELSE '파랑' END color"
				+ " FROM emp"
				+ " ORDER BY (CASE"
				+ "        WHEN color = '빨강' THEN 1"
				+ "        WHEN color = '주황' THEN 2"
				+ "        WHEN color = '노랑' THEN 3"
				+ "        WHEN color = '초록' THEN 4"
				+ "        ELSE 5 END) ASC";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, String> h = new HashMap<>();
			h.put("ename", rs.getString("ename"));
			h.put("job", rs.getString("job"));
			h.put("color", rs.getString("color"));
			list.add(h);
		}
		
		conn.close();
		return list;
	}
	
	// Map 사용 
	public static ArrayList<HashMap<String, Object>> selectDeptOnoffList() throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		String sql = "SELECT"
				+ " deptno deptNo, dname, loc, 'ON' onOff" // ON이라는 문자열값의 컬럼명은 onOff로 하겠다는 뜻
				+ " FROM dept";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("deptNo", rs.getInt("deptNo"));
			m.put("dname", rs.getString("dname"));
			m.put("loc", rs.getString("loc"));
			m.put("onOff", rs.getString("onOff"));
			
			list.add(m);
		}
		
		return list;
	}
	
	// VO를 사용
	public static ArrayList<Dept> selectDeptList() throws Exception{
		ArrayList<Dept> list = new ArrayList<>(); //ArrayList<Dept>는 Dept[]
		
		String sql = "SELECT"
				+ " deptno, deptNo, dname, loc"
				+ " FROM dept";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Dept d = new Dept();
			//d.deptNo = rs.getInt("deptNo");
			//d.loc = rs.getString("loc");
			//d.dname = rs.getString("dname");
			d.setDeptNo(rs.getInt("deptNo"));
			d.setDname(rs.getString("dname"));
			d.setLoc(rs.getString("loc"));
			list.add(d);
		}
		
		return list;
	}

}
