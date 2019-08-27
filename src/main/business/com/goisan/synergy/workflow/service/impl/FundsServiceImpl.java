package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.bean.FundsRelation;
import com.goisan.synergy.workflow.dao.FundsDao;
import com.goisan.synergy.workflow.service.FundsService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.Start;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/8 0008.
 */
@Service
public class FundsServiceImpl implements FundsService {
    @Resource
    private FundsDao fundsDao;

    public List<Funds> getFundsList(String id) {
        return fundsDao.getFundsList(id);
    }

    public List<Start> getRelationFundsList(String id) {
        return fundsDao.getRelationFundsList(id);
    }

    public List<Funds> fundsAction(Funds funds) {
        return fundsDao.fundsAction(funds);
    }

    public List<AutoComplete> selectPerson() {
        return fundsDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return fundsDao.selectDept();
    }

    public List<Funds> getProcessFundsList(Funds funds) {
        return fundsDao.getProcessFundsList(funds);
    }

    public List<Funds> fundsComplete(Funds funds) {
        return fundsDao.fundsComplete(funds);
    }

    public List<Funds> fundsProcess(Funds funds) {
        return fundsDao.fundsProcess(funds);
    }

    public Funds getFundsById(String id) {
        return fundsDao.getFundsById(id);
    }

    public Funds getRelationFundsById(String id) {
        return fundsDao.getRelationFundsById(id);
    }

    public void deleteById(String id) {
        fundsDao.deleteById(id);
    }

    public void insertFunds(Funds funds) {
        fundsDao.insertFunds(funds);
    }

    public void insertFundsAPP(Funds funds) {
        fundsDao.insertFundsAPP(funds);
    }

    public void updateFunds(Funds funds) {
        fundsDao.updateFunds(funds);
    }

    public void updateAppFunds(Funds funds) {
        fundsDao.updateAppFunds(funds);
    }

    public void updateFundsRequestFlag(Funds funds) {
        fundsDao.updateFundsRequestFlag(funds);
    }

    public String getStartById(String businessId) {
        return fundsDao.getStartById(businessId);
    }

    public void insertFundsRelation(FundsRelation fundsRelation) {
        fundsDao.insertFundsRelation(fundsRelation);
    }

    public void deleteRelationById(String businessId,String id) {
        fundsDao.deleteRelationById(businessId,id);
    }
}
