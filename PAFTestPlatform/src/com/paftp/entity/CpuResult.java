package com.paftp.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class CpuResult {

	private Integer id;
	private StressResult stressResult;
	private Date timestamp;
	private String cpuUser;
	private String cpuSys;
	private String cpuWait;

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

	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "stressresult_id")
	public StressResult getStressResult() {
		return stressResult;
	}

	public void setStressResult(StressResult stressResult) {
		this.stressResult = stressResult;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "timestamp")
	public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	@Column(name = "cpu_user", length = 8)
	public String getCpuUser() {
		return cpuUser;
	}

	public void setCpuUser(String cpuUser) {
		this.cpuUser = cpuUser;
	}

	@Column(name = "cpu_sys", length = 8)
	public String getCpuSys() {
		return cpuSys;
	}

	public void setCpuSys(String cpuSys) {
		this.cpuSys = cpuSys;
	}

	@Column(name = "cup_wait", length = 8)
	public String getCpuWait() {
		return cpuWait;
	}

	public void setCpuWait(String cpuWait) {
		this.cpuWait = cpuWait;
	}

}
