package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface FixedAssetsService {

    List<BaseBean> getFixedAssetsList(BaseBean baseBean);

    void saveFixedAssets(BaseBean baseBean);

    BaseBean getFixedAssetsById(String id);

    void updateFixedAssets(BaseBean baseBean);

    void delFixedAssets(String id);

}