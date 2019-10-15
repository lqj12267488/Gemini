package com.goisan.logistics.assets.service;

import com.goisan.logistics.assets.bean.Assets;
import com.goisan.logistics.assets.bean.AssetsDetails;
import com.goisan.logistics.assets.bean.AssetsLog;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/24.
 */
public interface AssetsService {

    List<Assets> assetsAction(Assets assets);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);

    Assets getAssetsById(String id);

    void insertAssets(Assets assets);

    void updateAssets(Assets assets);

    void deleteAssetsById(String id);

    void deleteAssetsDetailById(String assetsId);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();

    List<Assets> getAssetsByIds(String ids);

    void saveAssetsDetails(AssetsDetails assetsDetails);

    void saveAssetsLog(AssetsLog assetsLog);

    void saveAssetsDetailsAndLog(AssetsDetails assetsDetails, AssetsLog assetsLog);

    AssetsDetails getAssetsDetails(String id);

    void updateAssetsDetailsSaveAndLog(AssetsDetails details, AssetsLog assetsLog);

    Integer countAssetsDetailsByPid(String id);

    void updateAssetsDetailsByPid(String id, String direction, String status);

    List<AssetsDetails> getAssigned(AssetsDetails assetsDetails);

    void updateAssetsDetails(AssetsDetails details);

    List<AssetsDetails> getChanged(AssetsDetails assetsDetails);

    List<AssetsDetails> getAssetsDetailsList(AssetsDetails assetsDetails);

    List getLogs(String id);

    @Transactional
    List<Assets> exportAssets(String ids);

    List<AssetsDetails> exportAssignedList(String ids);

    List<Select2> getUserDictName(@Param("name") String name);

    List<Select2> getDeptName();

    List<Assets>  getAssetsIdByIds(@Param("ids") String ids);

    AssetsDetails doPrint(String assetsId);

    String selectDeptById(String userDept);

    String selectNameById(String userId);
}
