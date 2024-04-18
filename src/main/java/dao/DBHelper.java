package dao;

import java.io.FileReader;
import java.sql.*;
import java.util.Properties;

public class DBHelper {
	public static Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = null;
		
		// 클라우드 사용의 경우 TNS_ADMIN 매개값은 전자지갑의 위치임!
		// dbc:oracle:thin:@아이디?TNS_ADMIN=전자지갑의 위치
		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		
		
		// 보안이슈로 로컬 설정파일에서 불러오기 (소스코드에 비밀번호를 노출시키지 않음)
		FileReader fr = new FileReader("E:\\dev\\auth\\oracledb.properties");
		Properties prop = new Properties();
		prop.load(fr);
		
		String dbUser = prop.getProperty("dbUser");
		String dbPw = prop.getProperty("dbPw");
		
		conn = DriverManager.getConnection(dburl, dbUser, dbPw);
		
		return conn;
	}
	
	// getConnection()메서드 디버깅
	public static void main(String[] args) throws Exception{
		Connection conn =  new DBHelper().getConnection();
		System.out.println(conn + "--> 접속성공");
	}

}
