package com.goisan.approval.service.impl;

import com.goisan.approval.bean.ResourceApproval;
import com.goisan.approval.dao.ResourceApprovalDao;
import com.goisan.approval.service.ResourceApprovalService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceApprovalServiceImpl implements ResourceApprovalService {
@Resource
private ResourceApprovalDao resourceApprovalDao;

    public List<BaseBean> getResourceApprovalList(BaseBean baseBean) {
        return resourceApprovalDao.getResourceApprovalList(baseBean);
    }

    public void saveResourceApproval(BaseBean baseBean) {
        resourceApprovalDao.saveResourceApproval(baseBean);
    }

    public BaseBean getResourceApprovalById(String id) {
        return resourceApprovalDao.getResourceApprovalById(id);
    }

    public void updateResourceApproval(BaseBean baseBean) {
        resourceApprovalDao.updateResourceApproval(baseBean);
    }

    public void setResourceApproval(BaseBean baseBean) {
        resourceApprovalDao.setResourceApproval(baseBean);
    }

    public void delResourceApproval(String id) {
        resourceApprovalDao.delResourceApproval(id);
    }

    public void addApprovalPublic(ResourceApproval resourceApproval){
        resourceApprovalDao.addApprovalPublic(resourceApproval);
    }
    public void updateResourcePublice(String resourceId) {
        resourceApprovalDao.updateResourcePublice(resourceId);
    }
}
