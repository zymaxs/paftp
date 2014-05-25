package com.paftp.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class UserInfo {

	private Integer id;
	private String mobile;
	private String telephone;
	private String othermail;
	private String otherinfo;
	
	private UserinfoDepartment staticDepartment;
	private UserinfoPosition staticPosition;
	
	@Id
	@GenericGenerator(name = "generator", strategy = "increment")
	@GeneratedValue(generator = "generator")
	@Column(name = "ID", length = 11)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "mobile", length = 20)
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Column(name = "telephone", length = 20)
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	@Column(name = "othermail", length = 20)
	public String getOthermail() {
		return othermail;
	}

	public void setOthermail(String othermail) {
		this.othermail = othermail;
	}
	
	@Column(name = "otherinfo", length = 20)
	public String getOtherinfo() {
		return otherinfo;
	}

	public void setOtherinfo(String otherinfo) {
		this.otherinfo = otherinfo;
	}

	@OneToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
	@JoinColumn(name = "department_id")
	public UserinfoDepartment getStaticDepartment() {
		return staticDepartment;
	}

	public void setStaticDepartment(UserinfoDepartment staticDepartment) {
		this.staticDepartment = staticDepartment;
	}

	@OneToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
	@JoinColumn(name = "position_id")
	public UserinfoPosition getStaticPosition() {
		return staticPosition;
	}

	public void setStaticPosition(UserinfoPosition staticPosition) {
		this.staticPosition = staticPosition;
	}


}
