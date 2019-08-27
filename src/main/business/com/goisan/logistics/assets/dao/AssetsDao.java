package com.goisan.logistics.assets.dao;

import com.goisan.logistics.assets.bean.Assets;
import com.goisan.logistics.assets.bean.AssetsDetails;
import com.goisan.logistics.assets.bean.AssetsLog;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/24.
 */
@Repository
public interface AssetsDao {
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

    List<Assets> getAssetsByIds(@Param("ids") String ids);

    void saveAssetsDetails(AssetsDetails assetsDetails);

    void saveAssetsLog(AssetsLog assetsLog);

    AssetsDetails getAssetsDetails(String id);

    void updateAssetsDetails(AssetsDetails details);

    Integer countAssetsDetailsByPid(String id);

    void updateAssetsDetailsByPid(@Param("id") String id, @Param("direction") String direction,
                                  @Param("status") String status);

    List<AssetsDetails> getAssigned(AssetsDetails assetsDetails);

    List<AssetsDetails> getChanged(AssetsDetails assetsDetails);

    List<AssetsDetails> getAssetsDetailsList(AssetsDetails assetsDetails);

    List getLogs(String id);

    List<AssetsDetails> exportAssignedList(@Param("ids") String ids);

    List<Select2> getUserDictName(@Param("name") String name);

    List<Select2> getDeptName();

    /**
     * 耗材导出
     */
    List<Assets>  getAssetsIdByIds(@Param("ids") String ids);
}
