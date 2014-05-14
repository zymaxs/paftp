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
public class MemoryResult {

	private Integer id;
	private StressResult stressResult;
	private Date timestamp;
	private String memoryFree;

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

	@Column(name = "memory_free", length = 8)
	public String getMemoryFree() {
		return memoryFree;
	}

	public void setMemoryFree(String memoryFree) {
		this.memoryFree = memoryFree;
	}

}
