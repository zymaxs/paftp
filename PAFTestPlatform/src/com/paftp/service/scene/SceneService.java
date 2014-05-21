package com.paftp.service.scene;

import com.paftp.entity.Scene;

public interface SceneService {

	public void saveScene(Scene scene);

	public void updateScene(Scene scene);

	public Scene findSceneByID(int id);

	public Scene findSceneBySceneName(String scenename);

	public void deleteScene(Scene scene);

}
