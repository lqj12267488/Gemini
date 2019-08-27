package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.SoftInstall;
import com.goisan.system.bean.AutoComplete;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/3 0003.
 */
@Repository
public interface SoftInstallDao {
    List<SoftInstall> softAction( SoftInstall softinstall);

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
