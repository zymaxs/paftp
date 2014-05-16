package com.paftp.service.scene.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Scene;
import com.paftp.service.scene.SceneService;

@Service("SceneService")
public class SceneServiceImpl implements SceneService {

	@Resource
	private BaseDAO<Scene> baseDAO;

	@Override
	public void saveScene(Scene scene) {
		baseDAO.save(scene);
	}

	@Override
	public void updateScene(Scene scene) {
		baseDAO.save(scene);

	}

	@Override
	public Scene findSceneByID(int id) {
		return baseDAO.get(Scene.class, id);
	}

	@Override
	public Scene findSceneBySceneName(String scenename) {
		return baseDAO.get("form scene s where s.scenename = ?",
				new Object[] { scenename });
	}

	@Override
	public void deleteScene(Scene scene) {
		baseDAO.delete(scene);

	}

}
