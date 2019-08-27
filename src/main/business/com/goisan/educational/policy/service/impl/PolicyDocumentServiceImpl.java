package com.goisan.educational.policy.service.impl;

import com.goisan.educational.policy.bean.PolicyDocument;
import com.goisan.educational.policy.dao.PolicyDocumentDao;
import com.goisan.educational.policy.service.PolicyDocumentService;
import com.goisan.system.bean.RoleEmpDeptRelation;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class PolicyDocumentServiceImpl implements PolicyDocumentService{
    @Resource
    private PolicyDocumentDao policyDocumentDao;
    public List<PolicyDocument> policyDocumentAction(PolicyDocument policyDocument){return policyDocumentDao.policyDocumentAction(policyDocument);}
    public List<PolicyDocument> provincialDocumentAction(PolicyDocument policyDocument){return policyDocumentDao.provincialDocumentAction(policyDocument);}
    public List<PolicyDocument> collegeDocumentAction(PolicyDocument policyDocument){return policyDocumentDao.collegeDocumentAction(policyDocument);}
    public void deletePolicyDocumentById(String id){policyDocumentDao.deletePolicyDocumentById(id);}
    public PolicyDocument getPolicyDocumentById(String id){return policyDocumentDao.getPolicyDocumentById(id);}
    public void updatePolicyDocumentById(PolicyDocument policyDocument){policyDocumentDao.updatePolicyDocumentById(policyDocument);}
    public void insertPolicyDocument(PolicyDocument policyDocument){policyDocumentDao.insertPolicyDocument(policyDocument);}
    public List<RoleEmpDeptRelation> getRoleByPersonId(String id){ return policyDocumentDao.getRoleByPersonId(id); }
}
