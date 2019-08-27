package com.goisan.leaguebuilding.league.service;

import com.goisan.leaguebuilding.league.bean.League;
import com.goisan.leaguebuilding.league.bean.LeagueMemberLog;
import com.goisan.partybuilding.party.bean.Party;
import com.goisan.partybuilding.party.bean.PartyMemberLog;
import com.goisan.system.bean.Tree;

import java.util.List;

/**
 * Created by Administrator on 2017/7/26/026.
 */
public interface LeagueService {
    
    List<League> leagueAction(League league);

    League getLeagueById(String id);

    void insertLeague(League league);

    void updateLeague(League league);

    List checkName(League league);

    void deleteLeagueById(String id);

    List<League> getLeagueByIds(String substring);

    void updateRelationshipByIds(League league);

    League getLeagueDetailedById(String id);

    League selectLeagueById(String id);

    List getLeagueLogByPersonId(String personId);

    League getLeagueByTreeId(String id);

    List<Tree> getLeagueBranchTree();

    void insertLeagueMemberLog(LeagueMemberLog leagueMemberLog);
}
