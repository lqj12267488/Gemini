package com.goisan.approval.service;

import com.goisan.approval.bean.ResourceApproval;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceApprovalService {

    List<BaseBean> getResourceApprovalList(BaseBean baseBean);

    void saveResourceApproval(BaseBean baseBean);

    BaseBean getResourceApprovalById(String id);

    void updateResourceApproval(BaseBean baseBean);

    void setResourceApproval(BaseBean baseBean);

    void delResourceApproval(String id);

    void addApprovalPublic(ResourceApproval resourceApproval);

    void updateResourcePublice(String resourceId);

}