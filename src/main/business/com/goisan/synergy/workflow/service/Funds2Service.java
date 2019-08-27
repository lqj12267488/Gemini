package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Funds2;
import com.goisan.synergy.workflow.bean.Funds2Relation;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Start;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Repository
public interface Funds2Service {

    List<Start> getRelationFundsList(String id);

    List<Funds2> fundsAction(Funds2 funds2);

    List<Funds2> fundsProcess(Funds2 funds2);

    List<Funds2> fundsComplete(Funds2 funds2);

    List<AutoComplete> selectPerson();

    List<AutoComplete> selectDept();

    Funds2 getFundsById(String id);

    Funds2 getRelationFundsById(String id);

    void deleteById(String id);

    void insertFunds(Funds2 funds2);

    void insertFundsAPP(Funds2 funds2);

    void updateFunds(Funds2 funds2);

    void updateAppFunds(Funds2 funds2);

    void updateFundsRequestFlag(Funds2 funds2);

    String getStartById(String businessId);

    void insertFundsRelation(Funds2Relation funds2Relation);

    void deleteRelationById(String businessId, String id);

}
