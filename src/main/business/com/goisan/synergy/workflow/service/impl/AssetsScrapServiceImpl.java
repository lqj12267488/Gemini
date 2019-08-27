package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.AssetsScrap;
import com.goisan.synergy.workflow.dao.AssetsScrapDao;
import com.goisan.synergy.workflow.service.AssetsScrapService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.UserDic;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**资产报废管理
 * modify by wq on 2017/5/7 0007.
 */
@Service
public class AssetsScrapServiceImpl implements AssetsScrapService {
    @Resource
    private AssetsScrapDao assetsScrapDao;

    public List<AssetsScrap> assetsAction(AssetsScrap assetsScrap) {
        return assetsScrapDao.assetsAction(assetsScrap);
    }

    public void deleteAssetsById(String id) {
        assetsScrapDao.deleteAssetsById(id);
    }

    public AssetsScrap getAssetsById(String id) {
        return assetsScrapDao.getAssetsById(id);
    }

    public void updateAssetsById(AssetsScrap assetsScrap) {
        assetsScrapDao.updateAssetsById(assetsScrap);
    }

    public void insertAssets(AssetsScrap assetsScrap) {
        assetsScrapDao.insertAssets(assetsScrap);
    }

    public List<AssetsScrap> getAssetsList(AssetsScrap assetsScrap) {
        return assetsScrapDao.getAssetsList(assetsScrap);
    }

    public List<AutoComplete> selectDept() {
        return assetsScrapDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return assetsScrapDao.selectPerson();
    }
    public List<AssetsScrap> assetsProcessAction(AssetsScrap assetsScrap) {
        return assetsScrapDao.assetsProcessAction(assetsScrap);
    }
    public List<AssetsScrap> assetsCompleteAction(AssetsScrap assetsScrap) {
        return assetsScrapDao.assetsCompleteAction(assetsScrap);
    }

    public String getPersonNameById(String personId) {
        return  assetsScrapDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return assetsScrapDao.getDeptNameById(deptId);
    }

    public List<UserDic> checkName(AssetsScrap assetsScrap) {
        return assetsScrapDao.checkName(assetsScrap);
    }

    public List<UserDic> checkCode(AssetsScrap assetsScrap) {
        return assetsScrapDao.checkCode(assetsScrap);
    }
}
