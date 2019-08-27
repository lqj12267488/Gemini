package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.SoftInstall;
import com.goisan.synergy.workflow.dao.SoftInstallDao;
import com.goisan.synergy.workflow.service.SoftInstallService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/3 0003.
 */
@Service
public class SoftInstallServiceImpl implements SoftInstallService {

    @Resource
    private SoftInstallDao softInstallDao;
    public List<SoftInstall> softAction(SoftInstall softinstall) {
        return softInstallDao.softAction(softinstall);
    }

    public void deleteSoftById(String id) {
        softInstallDao.deleteSoftById(id);
    }

    public SoftInstall getSoftById(String id) {
        return softInstallDao.getSoftById(id);
    }

    public void updateSoftById(SoftInstall softinstall) {
        softInstallDao.updateSoftById(softinstall);
    }

    public void insertSoft(SoftInstall softInstall) { softInstallDao.insertSoft(softInstall);}

    public List<SoftInstall> getSoftList(SoftInstall softinstall) {
        return softInstallDao.getSoftList(softinstall);
    }

    public List<AutoComplete> selectDept()  {
        return softInstallDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return softInstallDao.selectPerson();
    }

    public List<SoftInstall> getProcessSoftList(SoftInstall softinstall) {
        return softInstallDao.getProcessSoftList(softinstall);
    }

    public List<SoftInstall> getCompleteSoftList(SoftInstall softinstall) {
        return softInstallDao.getCompleteSoftList(softinstall);
    }

}
