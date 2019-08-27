package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Funds3;
import com.goisan.synergy.workflow.bean.Funds3Relation;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Start;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Repository
public interface Funds3Dao {

    List<Funds3> getFundsList(String id);
    List<Funds3> fundsAction(Funds3 funds3);

    List<Funds3> fundsProcess(Funds3 funds3);

    List<Funds3> fundsComplete(Funds3 funds3);

    List<AutoComplete> selectPerson();

    List<Funds3> getProcessFundsList(Funds3 funds3);

    List<AutoComplete> selectDept();

    Funds3 getFundsById(String id);

    void deleteById(String id);

    void insertFunds(Funds3 funds3);

    void insertFundsAPP(Funds3 funds3);

    void updateFunds(Funds3 funds3);

    void updateFundsRequestFlag(Funds3 funds3);

    String getStartById(String businessId);

    List<Start> getRelationFundsList(String id);

    Funds3 getRelationFundsById(String id);

    void insertFundsRelation(Funds3Relation funds3Relation);

    void deleteRelationById(@Param(value = "businessId") String businessId, @Param(value = "id") String id);

    void updateAppFunds(Funds3 funds3);

}
