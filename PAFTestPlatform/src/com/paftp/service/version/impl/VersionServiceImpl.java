package com.paftp.service.version.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Version;
import com.paftp.service.version.VersionService;

@Service("versionService")
public class VersionServiceImpl implements VersionService {

	@Resource
	private BaseDAO<Version> baseDAO;

	@Override
	public void saveVersion(Version version) {
		baseDAO.save(version);

	}

	@Override
	public void updateVersion(Version version) {
		baseDAO.save(version);

	}

	@Override
	public Version findVersionById(int id) {
		return baseDAO.get(Version.class, id);
	}

	@Override
	public Version findVersionByVersionNum(String versionnum) {
		return baseDAO.get("from Version v where v.versionNum = ?",
				new Object[] { versionnum });
	}

	@Override
	public void deleteVersion(Version version) {
		baseDAO.delete(version);

	}

}
