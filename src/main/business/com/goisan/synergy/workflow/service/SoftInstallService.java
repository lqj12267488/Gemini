package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.SoftInstall;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/5/4 0004.
 */
public interface SoftInstallService {
    List<SoftInstall> softAction(SoftInstall softinstall);

    void deleteSoftById(String id);

    SoftInstall getSoftById(String id);

    void updateSoftById(SoftInstall softinstall);

    void insertSoft(SoftInstall softInstall);

    List<SoftInstall> getSoftList(SoftInstall softinstall);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();
    List<SoftInstall> getProcessSoftList(SoftInstall softinstall);
    List<SoftInstall> getCompleteSoftList(SoftInstall softinstall);
}
