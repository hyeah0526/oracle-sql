package vo;
// VO(Value Object)과 DTO(Data Transfer Object), Domain
// Domain이란? 테이블 속성값의 범위

// int 1개/String 2개이므로 참조타입 HashMap을 사용해도 되지만, VO타입도 사용가능
// 지금까지는 결과셋을 자바에서 HashMap을 사용했고, VO타입으로도 진행 
// 뭘 써도 되는지 기준은 없지만 본인이 좀 더 좋은 결과를 선택

public class Dept {
	// public-> private으로 변경
	private int deptNo;
	private String dname;
	private String loc;
	
	
	// Setter, Getter
	public int getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	
	
	

}
