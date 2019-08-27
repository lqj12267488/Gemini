package com.goisan.approval.dao;

import com.goisan.approval.bean.ResourcePrivate;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Files;

import java.util.List;

public interface ResourcePrivateDao {

    List<ResourcePrivate> getResourcePrivateList(ResourcePrivate resourcePrivate);

    void saveResourcePrivate(ResourcePrivate resourcePrivate);

    ResourcePrivate getResourcePrivateById(String id);

    void updateResourcePrivate(ResourcePrivate resourcePrivate);

    void updatePrivateFlag(ResourcePrivate resourcePrivate);

    void delResourcePrivate(String id);

    List<ResourcePrivate> myResourceRecycleList(ResourcePrivate resourcePrivate);

    void backResourceRecycle(String id);

    void delResourceRecycle(String id);

    void delResourceURL(String id);

    Files selectFileURL(String id);

}
