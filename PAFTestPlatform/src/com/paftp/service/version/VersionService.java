package com.paftp.service.version;

import com.paftp.entity.Version;

public interface VersionService {

	public void saveVersion(Version version);

	public void updateVersion(Version version);

	public Version findVersionById(int id);

	public Version findVersionByVersionNum(String versionnum);

	public void deleteVersion(Version version);
}
