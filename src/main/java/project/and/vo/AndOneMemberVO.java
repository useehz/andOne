package project.and.vo;

public class AndOneMemberVO {
	private String m_nickname;
	private byte[] userImg;
	private String resultUserImg;
	private String om_leader;
	private String om_state;
	private String m_id;
	private String one_id;
	private String om_date;
	private String one_price;
	private String one_state;
	
	
	
	public AndOneMemberVO() {
		System.out.println("AndOneMemberVO");
	}
	
	
	
	public String getOne_state() {
		return one_state;
	}



	public void setOne_state(String one_state) {
		this.one_state = one_state;
	}



	public String getOne_price() {
		return one_price;
	}


	public void setOne_price(String one_price) {
		this.one_price = one_price;
	}


	public String getOne_id() {
		return one_id;
	}

	public void setOne_id(String one_id) {
		this.one_id = one_id;
	}

	public String getOm_date() {
		return om_date;
	}

	public void setOm_date(String om_date) {
		this.om_date = om_date;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getOm_leader() {
		return om_leader;
	}

	public void setOm_leader(String om_leader) {
		this.om_leader = om_leader;
	}

	public String getOm_state() {
		return om_state;
	}

	public void setOm_state(String om_state) {
		this.om_state = om_state;
	}

	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public byte[] getUserImg() {
		return userImg;
	}
	public void setUserImg(byte[] userImg) {
		this.userImg = userImg;
	}
	public String getResultUserImg() {
		return resultUserImg;
	}
	public void setResultUserImg(String resultUserImg) {
		this.resultUserImg = resultUserImg;
	}

}
