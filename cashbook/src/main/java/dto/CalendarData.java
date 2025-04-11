package dto;

public class CalendarData {
	private int day; // 날짜(1~31)
	private int incomeCnt; // 수입 건수
	private int expenseCnt; // 지출 건수
	
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getIncomeCnt() {
		return incomeCnt;
	}
	public void setIncomeCnt(int incomeCnt) {
		this.incomeCnt = incomeCnt;
	}
	public int getExpenseCnt() {
		return expenseCnt;
	}
	public void setExpenseCnt(int expenseCnt) {
		this.expenseCnt = expenseCnt;
	}
	@Override // 객체의 내용을 보기 쉽게 문자열로 출력하기 위해
	public String toString() {
		return "CalendarDate [day=" + day + ", incomeCnt=" + incomeCnt + ", expenseCnt=" + expenseCnt + "]";
	}
	
	
}
