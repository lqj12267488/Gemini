package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.bean.Funds1;
import com.goisan.synergy.workflow.bean.Funds1Relation;
import com.goisan.synergy.workflow.bean.FundsRelation;
import com.goisan.synergy.workflow.dao.Funds1Dao;
import com.goisan.synergy.workflow.dao.FundsDao;
import com.goisan.synergy.workflow.service.Funds1Service;
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
public class Funds1ServiceImpl implements Funds1Service {
    @Resource
    private Funds1Dao funds1Dao;

    public List<Funds1> getFundsList(String id) {
        return funds1Dao.getFundsList(id);
    }

    public List<Start> getRelationFundsList(String id) {
        return funds1Dao.getRelationFundsList(id);
    }

    public List<Funds1> fundsAction(Funds1 funds1) {
        return funds1Dao.fundsAction(funds1);
    }

    public List<AutoComplete> selectPerson() {
        return funds1Dao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return funds1Dao.selectDept();
    }

    public List<Funds1> getProcessFundsList(Funds1 funds1) {
        return funds1Dao.getProcessFundsList(funds1);
    }

    public List<Funds1> fundsComplete(Funds1 funds1) {
        return funds1Dao.fundsComplete(funds1);
    }

    public List<Funds1> fundsProcess(Funds1 funds1) {
        return funds1Dao.fundsProcess(funds1);
    }

    public Funds1 getFundsById(String id) {
        return funds1Dao.getFundsById(id);
    }

    public Funds1 getRelationFundsById(String id) {
        return funds1Dao.getRelationFundsById(id);
    }

    public void deleteById(String id) {
        funds1Dao.deleteById(id);
    }

    public void insertFunds(Funds1 funds1) {
        funds1Dao.insertFunds(funds1);
    }

    public void insertFundsAPP(Funds1 funds1) {
        funds1Dao.insertFundsAPP(funds1);
    }

    public void updateFunds(Funds1 funds1) {
        funds1Dao.updateFunds(funds1);
    }

    public void updateAppFunds(Funds1 funds1) {
        funds1Dao.updateAppFunds(funds1);
    }

    public void updateFundsRequestFlag(Funds1 funds1) {
        funds1Dao.updateFundsRequestFlag(funds1);
    }

    public String getStartById(String businessId) {
        return funds1Dao.getStartById(businessId);
    }

    public void insertFundsRelation(Funds1Relation funds1Relation) {
        funds1Dao.insertFundsRelation(funds1Relation);
    }

    public void deleteRelationById(String businessId,String id) {
        funds1Dao.deleteRelationById(businessId,id);
    }
}
