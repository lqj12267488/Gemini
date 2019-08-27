package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Document;
import com.goisan.synergy.workflow.bean.DocumentProcess;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.Start;

import java.util.List;

public interface DocumentService {
    List<Document> getDocumentList(Document document);
    void insertDocument(Document document);
    Document getDocumentById(String id);
    void updateDocumentById(Document document);
    void deleteDocumentById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<Document> getProcessList(Document document);
    List<Document> getCompleteList(Document document);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    void updateDocumentByBusinessId(Document document);
    String getRemarkByRoleDeans(Start start);
    List<Handle> getDocumentHandleById(String id);
    Start getStartByBusinessId(String id);
    String getHandleTime(String id);
    List<Document> getSymbolById(String symbol);

    /**
     * 公文流程
     * @param documentProcess
     * @return
     */
    List<DocumentProcess> getDocumentProcessList(DocumentProcess documentProcess);
    void insertDocumentProcess(DocumentProcess documentProcess);
    DocumentProcess getDocumentProcessById(String id);
    void updateDocumentProcessById(DocumentProcess documentProcess);
    void deleteDocumentProcessById(String id);
    String getFileIdByDocumentId(String id);
    List<DocumentProcess> getDocumentProcessByBusinessId(String businessId);
    String getEditionByDocumentId(String id);
    String getNameByPersonId(String personId);
    String getRoleByNodeId(String workflowId, String nodeId);
    String getDeptByPersonId(String personId);
    String getHandleRole(String roleId);

    String getDocumentHandleById2(String id, String roleName);

    List<Document> getRequestFlagById(String id);
}
