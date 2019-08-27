package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Funds2;
import com.goisan.synergy.workflow.bean.Funds2Relation;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Start;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Repository
public interface Funds2Dao {

    List<Funds2> getFundsList(String id);
    List<Funds2> fundsAction(Funds2 funds2);

    List<Funds2> fundsProcess(Funds2 funds2);

    List<Funds2> fundsComplete(Funds2 funds2);

    List<AutoComplete> selectPerson();

    List<Funds2> getProcessFundsList(Funds2 funds2);

    List<AutoComplete> selectDept();

    Funds2 getFundsById(String id);

    void deleteById(String id);

    void insertFunds(Funds2 funds2);

    void insertFundsAPP(Funds2 funds2);

    void updateFunds(Funds2 funds2);

    void updateFundsRequestFlag(Funds2 funds2);

    String getStartById(String businessId);

    List<Start> getRelationFundsList(String id);

    Funds2 getRelationFundsById(String id);

    void insertFundsRelation(Funds2Relation funds2Relation);

    void deleteRelationById(@Param(value = "businessId") String businessId, @Param(value = "id") String id);

    void updateAppFunds(Funds2 funds2);

}
