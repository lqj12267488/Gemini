package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.bean.FundsRelation;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.Start;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Repository
public interface FundsService {

    List<Start> getRelationFundsList(String id);

    List<Funds> fundsAction(Funds funds);

    List<Funds> fundsProcess(Funds funds);

    List<Funds> fundsComplete(Funds funds);

    List<AutoComplete> selectPerson();

    List<AutoComplete> selectDept();

    Funds getFundsById(String id);

    Funds getRelationFundsById(String id);

    void deleteById(String id);

    void insertFunds(Funds funds);

    void insertFundsAPP(Funds funds);

    void updateFunds(Funds funds);

    void updateAppFunds(Funds funds);

    void updateFundsRequestFlag(Funds funds);

    String getStartById(String businessId);

    void insertFundsRelation(FundsRelation fundsRelation);

    void deleteRelationById(String businessId,String id);

}
