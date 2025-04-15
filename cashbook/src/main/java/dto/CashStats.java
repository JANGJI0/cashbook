package dto;

public class CashStats {
// cash로 받아올 수 있지만 cash는 1건의 대한 용도이고, 유지보수를 위해 하나의 목적에 맞게 딱 하나로 만드는게 안전
	private int year; // 년도별
	private int month; // 전체월별
	private String kind; // 수입 or 지출
	private int cnt; 	 // 건수
	private int total;	 // 총 금액
	public String getKind() {
		return kind;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
}
