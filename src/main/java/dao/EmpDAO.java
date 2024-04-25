package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Emp;

public class EmpDAO {
	// q006groupBy.jsp
	public static ArrayList<HashMap<String, Integer>> selectEmpSalStats() throws Exception{
		ArrayList<HashMap<String, Integer>> list = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// sql문 grade등급, count갯수, sum합계, avg평균, max최대값, min최소값을 grade순으로 정렬
		String sql = "SELECT "
					+ "	grade,"
					+ "	COUNT(*) count,"
					+ "	SUM(sal) sum,"
					+ "	AVG(sal) avg,"
					+ "	MAX(sal) max,"
					+ "	MIN(sal) min"
				+ " FROM emp"
				+ " GROUP BY grade"
				+ " ORDER BY grade ASC";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Integer> m = new HashMap<String, Integer>();
			m.put("grade", rs.getInt("grade"));
			m.put("count", rs.getInt("count"));
			m.put("sum", rs.getInt("sum"));
			m.put("avg", rs.getInt("avg"));
			m.put("max", rs.getInt("max"));
			m.put("min", rs.getInt("min"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	
	
	// q005orderBy.jsp
	public static ArrayList<Emp> selectEmpListSort(String col, String sort) throws Exception{
		ArrayList<Emp> list = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		//매개값 디버깅
		System.out.println(col + " <-- col EmpDAO selectEmpListSort");
		System.out.println(sort + " <-- sort EmpDAO selectEmpListSort");
		
		/*
		 * 동적쿼리 :: 쿼리문자열이 매개값에 따라 분리되어서 차리가 남
		 * 없음
		 * empno ASC
		 * empno DESC
		 * ename ASC
		 * ename DESC
		 * 
		 */
		
		String sql = "SELECT empno, ename"
				+ " FROM emp";
		
		if(col != null && sort != null) {
			sql = sql+" ORDER BY "+col+" "+sort;
		}
		
		stmt = conn.prepareStatement(sql);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Emp e = new Emp();
			e.setEmpNo(rs.getInt("empno"));
			e.setEname(rs.getString("ename"));
			list.add(e);
		}
		
		conn.close();
		return list;
	}
	
	// DEPTNO 뒤에 부서별 인원 같이 조회하는 메서드
	public static ArrayList<HashMap<String, Integer>> selectDeptNoCnt() throws Exception{
		ArrayList<HashMap<String, Integer>> list = new ArrayList<>();
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT deptno, count(*)"
				+ " FROM emp"
				+ " WHERE deptno IS NOT NULL"
				+ " GROUP BY deptno"
				+ " ORDER BY deptno";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Integer> h = new HashMap<String, Integer>();
			h.put("deptNo", rs.getInt("deptno"));
			h.put("cnt", rs.getInt("count(*)"));
			list.add(h);
		}
		conn.close();
		return list;
	}
	
	// 중복을 제외한 DEPTNO 목록을 출력하는 메서드
	public static ArrayList<Integer> selectDeptNoList() throws Exception{
		ArrayList<Integer> list = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT DISTINCT deptno deptNo"
				+ " FROM emp"
				+ " WHERE deptno IS NOT NULL"
				+ " ORDER BY deptno ASC";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Integer i = rs.getInt("deptNo"); //랩퍼타입과 기본타입 Auto Boxing
			list.add(i);
		}
		
		conn.close();
		return list;
	}
	
	
	// 조인으로 Map을 사용
	public static ArrayList<HashMap<String, Object>> selectEmpAndDeptList() throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT emp.empno empNo, emp.ename ename, emp.deptno deptNo,"
				+ " dept.dname dname"
				+ " FROM emp INNER JOIN dept"
				+ " ON emp.deptno = dept.deptno";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("empNo", rs.getInt("empNo"));
			m.put("ename", rs.getString("ename"));
			m.put("deptNo", rs.getInt("deptNo"));
			m.put("dname", rs.getString("dname"));
			list.add(m);
		}
				
		return list;
	}
	
	
	// VO사용
	public static ArrayList<Emp> selectEmpList() throws Exception{
		ArrayList<Emp> list = new ArrayList<>();
		
		String sql = "SELECT"
				+ " empno empNo, ename, sal"
				+ " FROM emp";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Emp e = new Emp();
			//e.empNo = rs.getInt("empNo");
			//e.ename = rs.getString("ename");
			//e.sal = rs.getDouble("sal");
			e.setEmpNo(rs.getInt("empNo"));
			e.setEname(rs.getString("ename"));
			e.setSal(rs.getDouble("sal"));
			list.add(e);
		}
		return list;
	}
	
	// q004WhereIn.jsp에서 호출
	// 
	public static ArrayList<Emp> selectEmpListByGrade(ArrayList<Integer> ckList) throws Exception{
		ArrayList<Emp> list = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT ename, grade"
				+ " FROM emp"
				+ " WHERE grade IN";
		
		// 경우의 수가 5가지
		if(ckList.size() == 1) {
			sql = sql + " (?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ckList.get(0));
			
		}else if(ckList.size() == 2) {
			sql = sql + " (?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ckList.get(0));
			stmt.setInt(2, ckList.get(1));
			
		}else if(ckList.size() == 3) {
			sql = sql + " (?, ?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ckList.get(0));
			stmt.setInt(2, ckList.get(1));
			stmt.setInt(3, ckList.get(2));
			
		}else if(ckList.size() == 4) {
			sql = sql + " (?, ?, ?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ckList.get(0));
			stmt.setInt(2, ckList.get(1));
			stmt.setInt(3, ckList.get(2));
			stmt.setInt(4, ckList.get(3));
			
		}else if(ckList.size() == 5){
			sql = sql + " (?, ?, ?, ?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ckList.get(0));
			stmt.setInt(2, ckList.get(1));
			stmt.setInt(3, ckList.get(2));
			stmt.setInt(4, ckList.get(3));
			stmt.setInt(5, ckList.get(4));
		}
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Emp e = new Emp(); //emp에 넣어주기
			e.setEname(rs.getString("ename"));
			e.setGrade(rs.getInt("grade"));
			list.add(e);
		}
		
		conn.close();
		return list;
	}
}
