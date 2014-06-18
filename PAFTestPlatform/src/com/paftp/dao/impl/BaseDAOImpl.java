package com.paftp.dao.impl;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.TestcaseCountDto;
import com.paftp.entity.ApplySut;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;

@Repository("baseDAO")
@SuppressWarnings("all")
public class BaseDAOImpl<T> implements BaseDAO<T> {

	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public Serializable save(T o) {
		return this.getCurrentSession().save(o);
	}

	public void delete(T o) {
		this.getCurrentSession().delete(o);
	}

	public void update(T o) {
		this.getCurrentSession().update(o);
	}

	public void saveOrUpdate(T o) {
		this.getCurrentSession().saveOrUpdate(o);
	}

	public List<T> find(String hql) {
		return this.getCurrentSession().createQuery(hql).list();
	}

	public List<T> find(String hql, Object[] param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return q.list();
	}

	public List<T> find(String hql, List<Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.list();
	}

	public List<T> find(String hql, Object[] param, Integer page, Integer rows) {
		if (page == null || page < 1) {
			page = 1;
		}
		if (rows == null || rows < 1) {
			rows = 10;
		}
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}
	
	public List<T> find(String hql, Integer page, Integer rows) {
		if (page == null || page < 1) {
			page = 1;
		}
		if (rows == null || rows < 1) {
			rows = 10;
		}
		Query q = this.getCurrentSession().createQuery(hql);

		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}

	public List<T> find(String hql, List<Object> param, Integer page,
			Integer rows) {
		if (page == null || page < 1) {
			page = 1;
		}
		if (rows == null || rows < 1) {
			rows = 10;
		}
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}

	public T get(Class<T> c, Serializable id) {
		return (T) this.getCurrentSession().get(c, id);
	}

	public T get(String hql, Object[] param) {
		List<T> l = this.find(hql, param);
		if (l != null && l.size() > 0) {
			return l.get(0);
		} else {
			return null;
		}
	}

	public T get(String hql, List<Object> param) {
		List<T> l = this.find(hql, param);
		if (l != null && l.size() > 0) {
			return l.get(0);
		} else {
			return null;
		}
	}

	public Long count(String hql) {
		Query q = this.getCurrentSession().createQuery(hql);
		Long quantity =(Long) q.uniqueResult();
		return quantity;
	}

	public Long count(String hql, Object[] param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return (Long) q.uniqueResult();
	}

	public Long count(String hql, List<Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return (Long) q.uniqueResult();
	}

	public Integer executeHql(String hql) {
		return this.getCurrentSession().createQuery(hql).executeUpdate();
	}

	public Integer executeHql(String hql, Object[] param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return q.executeUpdate();
	}

	public Integer executeHql(String hql, List<Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.executeUpdate();
	}

	public List<T> findbyconditions(HashMap<String, Object> param, Integer page, Integer row){
		
		if (page == null || page < 1) {
			page = 1;
		}
		if (row == null || row < 1) {
			row = 10;
		}
		
		DetachedCriteria dc = DetachedCriteria.forClass(ApplySut.class);
		
		Iterator<Entry<String, Object>> iter = param.entrySet().iterator();
		
		while(iter.hasNext()){
			
			Entry<String, Object> condition = iter.next();     
			if (condition.getValue() != null  && !condition.getValue().equals("")) {
				if(condition.getValue() instanceof Date){
					if(condition.getKey().equals("starttime")){
					dc.add(Restrictions.ge("applytime",condition.getValue()));
					}else{
						dc.add(Restrictions.le("applytime",condition.getValue()));
					}
				}else{
		           dc.add(Restrictions.eq(condition.getKey(),condition.getValue()));
				}
				}
		}
		
		dc.addOrder(Order.asc("applysutstatus.id"));
		dc.addOrder(Order.desc("applytime"));
	
		
		Criteria c = dc.getExecutableCriteria(this.getCurrentSession());
		
		List<ApplySut> applySuts = c.list();
		
		return c.setFirstResult((page - 1)* row).setMaxResults(row).list();
	}
	
	public List<T> findbyconditions(HashMap<String, Object> param){
		
		DetachedCriteria dc = DetachedCriteria.forClass(Testcase.class);
		
		Iterator<Entry<String, Object>> iter = param.entrySet().iterator();
		
		while(iter.hasNext()){
			
			Entry<String, Object> condition = iter.next();     
			if (condition.getValue() != null  && condition.getValue().equals("") == false && condition.getValue().equals("All") == false) {
		
		           dc.add(Restrictions.eq(condition.getKey(),condition.getValue()));
				}
		}

		Criteria c = dc.getExecutableCriteria(this.getCurrentSession());
		
		List<Testcase> testcases = c.list();
		
		return  (List<T>) testcases;
	}

	public Long count(HashMap<String, Object> param){
		
	DetachedCriteria dc = DetachedCriteria.forClass(ApplySut.class);
	
		Iterator<Entry<String, Object>> iter = param.entrySet().iterator();
		
		while(iter.hasNext()){
			
			Entry<String, Object> condition = iter.next();     
			if (condition.getValue() != null && !condition.getValue().equals("")) {
				if(condition.getValue() instanceof Date){
					if(condition.getKey().equals("starttime")){
					dc.add(Restrictions.ge("applytime",condition.getValue()));
					}else{
						dc.add(Restrictions.le("applytime",condition.getValue()));
					}
				}else{
		           dc.add(Restrictions.eq(condition.getKey(),condition.getValue()));
				}
				}
		}
		
		Criteria c = dc.getExecutableCriteria(this.getCurrentSession());
		
		List<ApplySut> applySuts = c.list();
		
		long num = applySuts.size();
		
		return num;
	}

	@Override
	public List<T> findbyconditionsfortestsuites(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		DetachedCriteria dc = DetachedCriteria.forClass(Testsuite.class);
		
		Iterator<Entry<String, Object>> iter = param.entrySet().iterator();
		
		while(iter.hasNext()){
			
			Entry<String, Object> condition = iter.next();     
			if (condition.getValue() != null  && !condition.getValue().equals("")) {
		
		           dc.add(Restrictions.eq(condition.getKey(),condition.getValue()));
				}
		}

		Criteria c = dc.getExecutableCriteria(this.getCurrentSession());
		
		return c.list();
	}

	@Override
	public List<T> getgroup(String hql, Object[] param) {
		// TODO Auto-generated method stub
		List<T> l = this.find(hql, param);
		if (l != null && l.size() > 0) {
			return (List<T>) l;
		} else {
			return null;
		}
	}

}
