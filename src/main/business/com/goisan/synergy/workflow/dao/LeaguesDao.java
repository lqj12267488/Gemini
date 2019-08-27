package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.LeagueRelation;
import com.goisan.synergy.workflow.bean.Leagues;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Start;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Repository
public interface LeaguesDao {

    List<Leagues> getLeaguesList(String id);
    List<Leagues> leaguesAction(Leagues leagues);

    List<Leagues> leaguesProcess(Leagues leagues);

    List<Leagues> leaguesComplete(Leagues leagues);

    List<AutoComplete> selectPerson();

    List<Leagues> getProcessLeaguesList(Leagues leagues);

    List<AutoComplete> selectDept();

    Leagues getLeaguesById(String id);

    void deleteById(String id);

    void insertLeagues(Leagues leagues);

    void insertLeagueAPP(Leagues leagues);

    void updateLeagues(Leagues leagues);

    void updateLeagueRequestFlag(Leagues leagues);

    String getStartById(String businessId);

    List<Start> getRelationLeaguesList(String id);

    Leagues getRelationLeaguesById(String id);

    void insertLeagueRelation(LeagueRelation leagueRelation);

    void deleteRelationById(@Param(value = "businessId") String businessId, @Param(value = "id") String id);

    void updateAppLeagues(Leagues leagues);

}
