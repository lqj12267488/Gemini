package com.goisan.approval.dao;

import com.goisan.approval.bean.ResourcePublic;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Tree;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResourcePublicDao {

    List<BaseBean> getResourcePublicList(BaseBean baseBean);

    List<BaseBean> getPublicList(BaseBean baseBean);

    void saveResourcePublic(BaseBean baseBean);

    void addResourcePublic(BaseBean baseBean);

    BaseBean getResourcePublicById(BaseBean baseBean);

    void updateResourcePublic(BaseBean baseBean);

    void delResourcePublic(String id);

    ResourcePublic toEditExcellect(BaseBean baseBean);

    List<Tree> getResourceTree();
}
