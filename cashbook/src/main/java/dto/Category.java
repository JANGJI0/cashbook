package dto;
// import java.lang.*;
public class Category { // 부모가 없다면 extends Object 자동으로 붙는다.
	/* public Category( ) {
			super(); // Object(); 호출
			// new 생성자 : new heap 영역에 this 필드를 생성하고 초기화
			this.category_no = 0;  // 원칙은 이 코드가 맞다.
			this.kind = null;
			this.title = null;
			this.createdate = null; // 이 필드 때문에 만들어지는거다.
	} */
	private int category_no; // 이런 필드가 만들어져야한다. // 자바스크립트, 파이선은 적으면 안된다.
	private String createdate;
	private String title;
	private String kind;
	public int getCategory_no() {
		return category_no;
	}
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	// 오버라이딩 부모가 가지고 있는 메소드를 재정의하는것.
	@Override
	public String toString() { // 원래 Object 거다.
		return "Category [category_no=" + category_no + ", createdate=" + createdate + ", title=" + title + ", kind="
				+ kind + "]";
	}
	
	//  toString : dto값을 한번에 출력할 수 있도록 String 값으로 반환
	
	
}
