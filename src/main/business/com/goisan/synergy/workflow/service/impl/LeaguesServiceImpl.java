package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.LeagueRelation;
import com.goisan.synergy.workflow.bean.Leagues;
import com.goisan.synergy.workflow.dao.LeaguesDao;
import com.goisan.synergy.workflow.service.LeaguesService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Start;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/8 0008.
 */
@Service
public class LeaguesServiceImpl implements LeaguesService {
    @Resource
    private LeaguesDao leaguesDao;

    public List<Leagues> getLeaguesList(String id) {
        return leaguesDao.getLeaguesList(id);
    }

    public List<Start> getRelationLeaguesList(String id) {
        return leaguesDao.getRelationLeaguesList(id);
    }

    public List<Leagues> leaguesAction(Leagues leagues) {
        return leaguesDao.leaguesAction(leagues);
    }

    public List<AutoComplete> selectPerson() {
        return leaguesDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return leaguesDao.selectDept();
    }

    public List<Leagues> getProcessLeaguesList(Leagues leagues) {
        return leaguesDao.getProcessLeaguesList(leagues);
    }

    public List<Leagues> leaguesComplete(Leagues leagues) {
        return leaguesDao.leaguesComplete(leagues);
    }

    public List<Leagues> leaguesProcess(Leagues leagues) {
        return leaguesDao.leaguesProcess(leagues);
    }

    public Leagues getLeaguesById(String id) {
        return leaguesDao.getLeaguesById(id);
    }

    public Leagues getRelationLeaguesById(String id) {
        return leaguesDao.getRelationLeaguesById(id);
    }

    public void deleteById(String id) {
        leaguesDao.deleteById(id);
    }

    public void insertLeagues(Leagues leagues) {
        leaguesDao.insertLeagues(leagues);
    }

    public void insertLeagueAPP(Leagues leagues) {
        leaguesDao.insertLeagueAPP(leagues);
    }

    public void updateLeagues(Leagues leagues) {
        leaguesDao.updateLeagues(leagues);
    }

    public void updateAppLeagues(Leagues leagues) {
        leaguesDao.updateAppLeagues(leagues);
    }

    public void updateLeagueRequestFlag(Leagues leagues) {
        leaguesDao.updateLeagueRequestFlag(leagues);
    }

    public String getStartById(String businessId) {
        return leaguesDao.getStartById(businessId);
    }

    public void insertLeagueRelation(LeagueRelation leagueRelation) {
        leaguesDao.insertLeagueRelation(leagueRelation);
    }

    public void deleteRelationById(String businessId,String id) {
        leaguesDao.deleteRelationById(businessId,id);
    }
}
