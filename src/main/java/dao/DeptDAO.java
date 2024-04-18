package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Dept;

public class DeptDAO {
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
			d.deptNo = rs.getInt("deptNo");
			d.dname = rs.getString("dname");
			d.loc = rs.getString("loc");
			list.add(d);
		}
		
		return list;
	}

}
