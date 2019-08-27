package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.AssetsScrap;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.UserDic;

import java.util.List;

/**资产报废管理
 * modify by wq on 2017/5/7 0007.
 */
public interface AssetsScrapService {
    List<AssetsScrap> assetsAction(AssetsScrap assetsScrap);

    void deleteAssetsById(String id);

    AssetsScrap getAssetsById(String id);

    void updateAssetsById(AssetsScrap assetsScrap);

    void insertAssets(AssetsScrap assetsScrap);

    List<AssetsScrap> getAssetsList(AssetsScrap assetsScrap);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();

    List<AssetsScrap> assetsProcessAction(AssetsScrap assetsScrap);

    List<AssetsScrap> assetsCompleteAction(AssetsScrap assetsScrap);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);
    List<UserDic> checkName(AssetsScrap assetsScrap);
    List<UserDic> checkCode(AssetsScrap assetsScrap);
}
