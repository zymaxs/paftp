package com.paftp.service.team;

import java.util.List;

import com.paftp.entity.Team;

public interface TeamService {

	public void saveTeam(Team team);

	public void updateTeam(Team team);

	public Team findTeamById(int id);

	public Team findTeamByName(String name);

	public void deleteTeam(Team team);

	public List<Team> findAllList();

	// public User findUserByNameAndPassword(String username, String password);

}
