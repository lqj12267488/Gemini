package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Document;
import com.goisan.synergy.workflow.bean.DocumentProcess;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.Start;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DocumentDao {
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
    Start getStartByBusinessId(String id);
    List<Handle> getDocumentHandleById(String id);
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
    String getRoleByNodeId(@Param("workflowId") String workflowId, @Param("nodeId") String nodeId);
    String getHandleRole(String roleId);
    String getDeptByPersonId(String personId);

    String getDocumentHandleById2(@Param("id") String id, @Param("roleName") String roleName);

    List<Document> getRequestFlagById(String id);
}
