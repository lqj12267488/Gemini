package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.bean.Funds3;
import com.goisan.synergy.workflow.bean.Funds3Relation;
import com.goisan.synergy.workflow.bean.FundsRelation;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Start;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Repository
public interface Funds3Service {

    List<Start> getRelationFundsList(String id);

    List<Funds3> fundsAction(Funds3 funds3);

    List<Funds3> fundsProcess(Funds3 funds3);

    List<Funds3> fundsComplete(Funds3 funds3);

    List<AutoComplete> selectPerson();

    List<AutoComplete> selectDept();

    Funds3 getFundsById(String id);

    Funds3 getRelationFundsById(String id);

    void deleteById(String id);

    void insertFunds(Funds3 funds3);

    void insertFundsAPP(Funds3 funds3);

    void updateFunds(Funds3 funds3);

    void updateAppFunds(Funds3 funds3);

    void updateFundsRequestFlag(Funds3 funds3);

    String getStartById(String businessId);

    void insertFundsRelation(Funds3Relation funds3Relation);

    void deleteRelationById(String businessId, String id);

}
