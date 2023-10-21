package theater.visitor;

import java.sql.Timestamp;

public class VisitorDTO {
	private String id;
	private String pwd;
	private String name;
	private char gender;
	private String tel;
	private String email;
	private String birthday;//java.sql.Date 대신 String을 사용해야 useBean의 자동입력을 사용가능.
	private String address1;
	private String address2;
	private String seen_mov;
	private Timestamp reg_date;

	public String getId() {
		return id;
	}

	public String getPwd() {
		return pwd;
	}

	public String getName() {
		return name;
	}

	public char getGender() {
		return gender;
	}

	public String getTel() {
		return tel;
	}

	public String getEmail() {
		return email;
	}

	public String getBirthday() {
		return birthday;
	}

	public String getAddress1() {
		return address1;
	}

	public String getAddress2() {
		return address2;
	}

	public String getSeen_mov() {
		return seen_mov;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public void setSeen_mov(String seen_mov) {
		this.seen_mov = seen_mov;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

}
