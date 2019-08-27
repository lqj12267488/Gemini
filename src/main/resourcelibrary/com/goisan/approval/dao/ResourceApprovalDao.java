package com.goisan.approval.dao;

import com.goisan.approval.bean.ResourceApproval;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceApprovalDao {

    List<BaseBean> getResourceApprovalList(BaseBean baseBean);

    void saveResourceApproval(BaseBean baseBean);

    BaseBean getResourceApprovalById(String id);

    void updateResourceApproval(BaseBean baseBean);

    void setResourceApproval(BaseBean baseBean);

    void delResourceApproval(String id);

    void addApprovalPublic(ResourceApproval resourceApproval);

    void updateResourcePublice(String resourceId);
}
