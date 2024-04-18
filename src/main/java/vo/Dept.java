package vo;
// VO(Value Object)과 DTO(Data Transfer Object), Domain
// Domain이란? 테이블 속성값의 범위

// int 1개/String 2개이므로 참조타입 HashMap을 사용해도 되지만, VO타입도 사용가능
// 지금까지는 결과셋을 자바에서 HashMap을 사용했고, VO타입으로도 진행 
// 뭘 써도 되는지 기준은 없지만 본인이 좀 더 좋은 결과를 선택

public class Dept {
	// 
	public int deptNo;
	public String dname;
	public String loc;
	

}
