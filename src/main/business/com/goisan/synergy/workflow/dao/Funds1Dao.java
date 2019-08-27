package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Funds1;
import com.goisan.synergy.workflow.bean.Funds1Relation;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Start;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Repository
public interface Funds1Dao {

    List<Funds1> getFundsList(String id);
    List<Funds1> fundsAction(Funds1 funds1);

    List<Funds1> fundsProcess(Funds1 funds1);

    List<Funds1> fundsComplete(Funds1 funds1);

    List<AutoComplete> selectPerson();

    List<Funds1> getProcessFundsList(Funds1 funds1);

    List<AutoComplete> selectDept();

    Funds1 getFundsById(String id);

    void deleteById(String id);

    void insertFunds(Funds1 funds1);

    void insertFundsAPP(Funds1 funds1);

    void updateFunds(Funds1 funds1);

    void updateFundsRequestFlag(Funds1 funds1);

    String getStartById(String businessId);

    List<Start> getRelationFundsList(String id);

    Funds1 getRelationFundsById(String id);

    void insertFundsRelation(Funds1Relation funds1Relation);

    void deleteRelationById(@Param(value = "businessId") String businessId, @Param(value = "id") String id);

    void updateAppFunds(Funds1 funds1);

}
