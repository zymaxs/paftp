package com.paftp.service.team.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Team;
import com.paftp.entity.User;
import com.paftp.service.team.TeamService;

@Service("teamService")
public class TeamServiceImpl implements TeamService {

	@Resource
	private BaseDAO<Team> baseDAO;
	@Resource
	private BaseDAO<User> userDAO;

	@Override
	public void saveTeam(Team team) {
		baseDAO.save(team);
	}

	@Override
	public void updateTeam(Team team) {
		baseDAO.update(team);
	}

	@Override
	public Team findTeamById(int id) {
		return baseDAO.get(Team.class, id);
	}

	@Override
	public Team findTeamByName(String teamname) {
		return baseDAO.get(" from Team u where u.teamName = ?",
				new Object[] { teamname });
	}

	@Override
	public void deleteTeam(Team team) {
		// List<User> users = team.getUsers();
		// int size = team.getUsers().size();
		// for(int i=0;i<size;i++){
		// users.get(i).setTeam(null);
		// userDAO.update(users.get(i));
		// }
		baseDAO.delete(team);

	}

	@Override
	public List<Team> findAllList() {
		return baseDAO.find(" from Team");
	}

}
