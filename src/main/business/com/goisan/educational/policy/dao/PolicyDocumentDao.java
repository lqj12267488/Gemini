package com.goisan.educational.policy.dao;

import com.goisan.educational.policy.bean.PolicyDocument;
import com.goisan.system.bean.RoleEmpDeptRelation;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PolicyDocumentDao {
    List<PolicyDocument> policyDocumentAction(PolicyDocument policyDocument);
    List<PolicyDocument> provincialDocumentAction(PolicyDocument policyDocument);
    List<PolicyDocument> collegeDocumentAction(PolicyDocument policyDocument);
    void deletePolicyDocumentById(String id);
    PolicyDocument getPolicyDocumentById(String id);
    void updatePolicyDocumentById(PolicyDocument policyDocument);
    void insertPolicyDocument(PolicyDocument policyDocument);
    List<RoleEmpDeptRelation> getRoleByPersonId(String id);
}
