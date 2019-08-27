package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.bean.Funds3;
import com.goisan.synergy.workflow.bean.Funds3Relation;
import com.goisan.synergy.workflow.bean.FundsRelation;
import com.goisan.synergy.workflow.dao.Funds3Dao;
import com.goisan.synergy.workflow.dao.FundsDao;
import com.goisan.synergy.workflow.service.Funds3Service;
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
public class Funds3ServiceImpl implements Funds3Service {
    @Resource
    private Funds3Dao funds3Dao;

    public List<Funds3> getFundsList(String id) {
        return funds3Dao.getFundsList(id);
    }

    public List<Start> getRelationFundsList(String id) {
        return funds3Dao.getRelationFundsList(id);
    }

    public List<Funds3> fundsAction(Funds3 funds3) {
        return funds3Dao.fundsAction(funds3);
    }

    public List<AutoComplete> selectPerson() {
        return funds3Dao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return funds3Dao.selectDept();
    }

    public List<Funds3> getProcessFundsList(Funds3 funds3) {
        return funds3Dao.getProcessFundsList(funds3);
    }

    public List<Funds3> fundsComplete(Funds3 funds3) {
        return funds3Dao.fundsComplete(funds3);
    }

    public List<Funds3> fundsProcess(Funds3 funds3) {
        return funds3Dao.fundsProcess(funds3);
    }

    public Funds3 getFundsById(String id) {
        return funds3Dao.getFundsById(id);
    }

    public Funds3 getRelationFundsById(String id) {
        return funds3Dao.getRelationFundsById(id);
    }

    public void deleteById(String id) {
        funds3Dao.deleteById(id);
    }

    public void insertFunds(Funds3 funds3) {
        funds3Dao.insertFunds(funds3);
    }

    public void insertFundsAPP(Funds3 funds3) {
        funds3Dao.insertFundsAPP(funds3);
    }

    public void updateFunds(Funds3 funds3) {
        funds3Dao.updateFunds(funds3);
    }

    public void updateAppFunds(Funds3 funds3) {
        funds3Dao.updateAppFunds(funds3);
    }

    public void updateFundsRequestFlag(Funds3 funds3) {
        funds3Dao.updateFundsRequestFlag(funds3);
    }

    public String getStartById(String businessId) {
        return funds3Dao.getStartById(businessId);
    }

    public void insertFundsRelation(Funds3Relation funds3Relation) {
        funds3Dao.insertFundsRelation(funds3Relation);
    }

    public void deleteRelationById(String businessId,String id) {
        funds3Dao.deleteRelationById(businessId,id);
    }
}
