package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.bean.Funds2;
import com.goisan.synergy.workflow.bean.Funds2Relation;
import com.goisan.synergy.workflow.bean.FundsRelation;
import com.goisan.synergy.workflow.dao.Funds2Dao;
import com.goisan.synergy.workflow.dao.FundsDao;
import com.goisan.synergy.workflow.service.Funds2Service;
import com.goisan.synergy.workflow.service.FundsService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Start;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/8 0008.
 */
@Service
public class Funds2ServiceImpl implements Funds2Service {
    @Resource
    private Funds2Dao funds2Dao;

    public List<Funds2> getFundsList(String id) {
        return funds2Dao.getFundsList(id);
    }

    public List<Start> getRelationFundsList(String id) {
        return funds2Dao.getRelationFundsList(id);
    }

    public List<Funds2> fundsAction(Funds2 funds2) {
        return funds2Dao.fundsAction(funds2);
    }

    public List<AutoComplete> selectPerson() {
        return funds2Dao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return funds2Dao.selectDept();
    }

    public List<Funds2> getProcessFundsList(Funds2 funds2) {
        return funds2Dao.getProcessFundsList(funds2);
    }

    public List<Funds2> fundsComplete(Funds2 funds2) {
        return funds2Dao.fundsComplete(funds2);
    }

    public List<Funds2> fundsProcess(Funds2 funds2) {
        return funds2Dao.fundsProcess(funds2);
    }

    public Funds2 getFundsById(String id) {
        return funds2Dao.getFundsById(id);
    }

    public Funds2 getRelationFundsById(String id) {
        return funds2Dao.getRelationFundsById(id);
    }

    public void deleteById(String id) {
        funds2Dao.deleteById(id);
    }

    public void insertFunds(Funds2 funds2) {
        funds2Dao.insertFunds(funds2);
    }

    public void insertFundsAPP(Funds2 funds2) {
        funds2Dao.insertFundsAPP(funds2);
    }

    public void updateFunds(Funds2 funds2) {
        funds2Dao.updateFunds(funds2);
    }

    public void updateAppFunds(Funds2 funds2) {
        funds2Dao.updateAppFunds(funds2);
    }

    public void updateFundsRequestFlag(Funds2 funds2) {
        funds2Dao.updateFundsRequestFlag(funds2);
    }

    public String getStartById(String businessId) {
        return funds2Dao.getStartById(businessId);
    }

    public void insertFundsRelation(Funds2Relation funds2Relation) {
        funds2Dao.insertFundsRelation(funds2Relation);
    }

    public void deleteRelationById(String businessId,String id) {
        funds2Dao.deleteRelationById(businessId,id);
    }
}
