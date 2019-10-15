package com.goisan.logistics.assets.service.impl;

import com.goisan.logistics.assets.bean.Assets;
import com.goisan.logistics.assets.bean.AssetsDetails;
import com.goisan.logistics.assets.bean.AssetsLog;
import com.goisan.logistics.assets.dao.AssetsDao;
import com.goisan.logistics.assets.service.AssetsService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import com.goisan.system.tools.CommonUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/24.
 */
@Service
public class AssetsServiceImpl implements AssetsService {
    @Resource
    private AssetsDao assetsDao;

    public List<Assets> assetsAction(Assets assets) {
        return assetsDao.assetsAction(assets);
    }

    public String getPersonNameById(String personId) {
        return assetsDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return assetsDao.getDeptNameById(deptId);
    }

    public Assets getAssetsById(String id) {
        return assetsDao.getAssetsById(id);
    }

    public void insertAssets(Assets assets) {
        assetsDao.insertAssets(assets);
    }

    public void updateAssets(Assets assets) {
        assetsDao.updateAssets(assets);
    }

    public void deleteAssetsById(String id) {
        assetsDao.deleteAssetsById(id);
    }

    public void deleteAssetsDetailById(String assetsId) {
        assetsDao.deleteAssetsDetailById(assetsId);
    }

    public List<AutoComplete> selectDept() {
        return assetsDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return assetsDao.selectPerson();
    }

    public List<Assets> getAssetsByIds(String ids) {
        return assetsDao.getAssetsByIds(ids);
    }

    public void saveAssetsDetails(AssetsDetails assetsDetails) {
        assetsDao.saveAssetsDetails(assetsDetails);
    }

    public void saveAssetsLog(AssetsLog assetsLog) {
        assetsDao.saveAssetsLog(assetsLog);
    }

    public void saveAssetsDetailsAndLog(AssetsDetails assetsDetails, AssetsLog assetsLog) {
        saveAssetsDetails(assetsDetails);
        saveAssetsLog(assetsLog);
    }

    public AssetsDetails getAssetsDetails(String id) {
        return assetsDao.getAssetsDetails(id);
    }

    public void updateAssetsDetailsSaveAndLog(AssetsDetails details, AssetsLog assetsLog) {
        updateAssetsDetails(details);
        saveAssetsLog(assetsLog);
    }

    public void updateAssetsDetails(AssetsDetails details) {
        assetsDao.updateAssetsDetails(details);
    }

    public Integer countAssetsDetailsByPid(String id) {
        return assetsDao.countAssetsDetailsByPid(id);
    }

    public void updateAssetsDetailsByPid(String id, String direction, String status) {
        assetsDao.updateAssetsDetailsByPid(id, direction, status);
    }

    public List<AssetsDetails> getAssigned(AssetsDetails assetsDetails) {
        return assetsDao.getAssigned(assetsDetails);
    }

    public List<AssetsDetails> getChanged(AssetsDetails assetsDetails) {
        return assetsDao.getChanged(assetsDetails);
    }

    public List<AssetsDetails> getAssetsDetailsList(AssetsDetails assetsDetails) {
        return assetsDao.getAssetsDetailsList(assetsDetails);
    }

    public List getLogs(String id) {
        return assetsDao.getLogs(id);
    }

    @Override
    public List<Assets> exportAssets(String ids) {
        Assets assets = new Assets();
        assets.setId(ids);
        assets.setCreator(CommonUtil.getPersonId());
        assets.setCreateDept(CommonUtil.getDefaultDept());
        assets.setLevel(CommonUtil.getLoginUser().getLevel());
        return assetsDao.assetsAction(assets);
    }

    @Override
    public List<AssetsDetails> exportAssignedList(String ids) {
        return assetsDao.exportAssignedList(ids);
    }

    public List<Select2> getUserDictName(@Param("name") String name){ return assetsDao.getUserDictName(name); }

    public List<Select2> getDeptName(){ return assetsDao.getDeptName(); }

    @Override
    public  List<Assets>  getAssetsIdByIds(@Param("ids") String ids){ return assetsDao.getAssetsIdByIds(ids); }

    @Override
    public AssetsDetails doPrint(String assetsId) {
        return assetsDao.doPrint(assetsId);
    }

    @Override
    public String selectDeptById(String userDept) {
        return assetsDao.selectDeptById(userDept);
    }

    @Override
    public String selectNameById(String userId) {
        return assetsDao.selectNameById(userId);
    }
}
