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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class CaseChangeOperation {

	private Integer id;
	private CaseChangeHistory caseChangeHistory;
	private String oldValue;
	private String newValue;
	private String field;

	@Id
	@GenericGenerator(name = "generator", strategy = "increment")
	@GeneratedValue(generator = "generator")
	@Column(name = "id", length = 11)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	

	@ManyToOne(cascade = CascadeType.REFRESH)
	@JoinColumn(name = "casechangehistory_id")
	public CaseChangeHistory getCaseChangeHistory() {
		return caseChangeHistory;
	}

	public void setCaseChangeHistory(CaseChangeHistory caseChangeHistory) {
		this.caseChangeHistory = caseChangeHistory;
	}
	
	@Column(name = "old_value", length = 3072)
	public String getOldValue() {
		return oldValue;
	}

	public void setOldValue(String oldValue) {
		this.oldValue = oldValue;
	}
	
	@Column(name = "new_value", length = 3072)
	public String getNewValue() {
		return newValue;
	}

	public void setNewValue(String newValue) {
		this.newValue = newValue;
	}

	@Column(name = "field", length = 50)
	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}
}
