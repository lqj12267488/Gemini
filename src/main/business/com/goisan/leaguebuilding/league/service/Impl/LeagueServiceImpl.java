package com.goisan.leaguebuilding.league.service.Impl;

import com.goisan.leaguebuilding.league.bean.League;
import com.goisan.leaguebuilding.league.bean.LeagueMemberLog;
import com.goisan.leaguebuilding.league.dao.LeagueDao;
import com.goisan.leaguebuilding.league.service.LeagueService;
import com.goisan.system.bean.Tree;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;


/**
 * Created by Administrator on 2017/7/26/026.
 */
@Service
public class LeagueServiceImpl implements LeagueService {
    @Resource
    private LeagueDao leagueDao;

    public List<League> leagueAction(League league) {
        return leagueDao.leagueAction(league);
    }

    public League getLeagueById(String id) {
        return leagueDao.getLeagueById(id);
    }

    public void insertLeague(League league) {
        leagueDao.insertLeague(league);
    }

    public void updateLeague(League league) {
        leagueDao.updateLeague(league);
    }

    public List checkName(League league) {
        return leagueDao.checkName(league);
    }

    public void deleteLeagueById(String id) {
        leagueDao.deleteLeagueById(id);
    }

    public List<League> getLeagueByIds(String ids) {
        return leagueDao.getLeagueByIds(ids);
    }

    public void updateRelationshipByIds(League league) {
        leagueDao.updateRelationshipByIds(league);
    }

    public League getLeagueDetailedById(String id) {
        return leagueDao.getLeagueDetailedById(id);
    }

    public League selectLeagueById(String id) {
        return leagueDao.selectLeagueById(id);
    }

    public List getLeagueLogByPersonId(String personId) {
        return leagueDao.getLeagueLogByPersonId(personId);
    }

    public League getLeagueByTreeId(String id) {
        return leagueDao.getLeagueByTreeId(id);
    }

    public List<Tree> getLeagueBranchTree() {
        return leagueDao.getLeagueBranchTree();
    }

    public void insertLeagueMemberLog(LeagueMemberLog leagueMemberLog) {
        leagueDao.insertLeagueMemberLog(leagueMemberLog);
    }
}
