package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Document;
import com.goisan.synergy.workflow.bean.DocumentProcess;
import com.goisan.synergy.workflow.dao.DocumentDao;
import com.goisan.synergy.workflow.service.DocumentService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.Start;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DocumentServiceImpl implements DocumentService {
    @Resource
    private DocumentDao documentDao;

    public List<Document> getDocumentList(Document document) {
        return documentDao.getDocumentList(document);
    }

    public void insertDocument(Document document) {
        documentDao.insertDocument(document);
    }

    public Document getDocumentById(String id) {
        return documentDao.getDocumentById(id);
    }

    public void updateDocumentById(Document document) {
        documentDao.updateDocumentById(document);
    }

    public void deleteDocumentById(String id) {
        documentDao.deleteDocumentById(id);
    }

    public List<AutoComplete> autoCompleteDept() {
        return documentDao.autoCompleteDept();
    }

    public List<AutoComplete> autoCompleteEmployee() {
        return documentDao.autoCompleteEmployee();
    }

    public List<Document> getProcessList(Document document) {
        return documentDao.getProcessList(document);
    }

    public List<Document> getCompleteList(Document document) {
        return documentDao.getCompleteList(document);
    }

    public String getPersonNameById(String personId) {
        return documentDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return documentDao.getDeptNameById(deptId);
    }

    public void updateDocumentByBusinessId(Document document) {
        documentDao.updateDocumentByBusinessId(document);
    }

    public String getRemarkByRoleDeans(Start start) {
        return documentDao.getRemarkByRoleDeans(start);
    }

    public List<Handle> getDocumentHandleById(String id) {
        return documentDao.getDocumentHandleById(id);
    }

    public String getHandleTime(String id) {
        return documentDao.getHandleTime(id);
    }

    public List<Document> getSymbolById(String symbol) {
        return documentDao.getSymbolById(symbol);
    }

    /**
     * 公文流程
     *
     * @param documentProcess
     * @return
     */
    public List<DocumentProcess> getDocumentProcessList(DocumentProcess documentProcess) {
        return documentDao.getDocumentProcessList(documentProcess);
    }

    public void insertDocumentProcess(DocumentProcess documentProcess) {
        documentDao.insertDocumentProcess(documentProcess);
    }

    public DocumentProcess getDocumentProcessById(String id) {
        return documentDao.getDocumentProcessById(id);
    }

    public void updateDocumentProcessById(DocumentProcess documentProcess) {
        documentDao.updateDocumentProcessById(documentProcess);
    }

    public void deleteDocumentProcessById(String id) {
        documentDao.deleteDocumentProcessById(id);
    }

    public String getFileIdByDocumentId(String id) {
        return documentDao.getFileIdByDocumentId(id);
    }

    public List<DocumentProcess> getDocumentProcessByBusinessId(String businessId) {
        return documentDao.getDocumentProcessByBusinessId(businessId);
    }

    public String getEditionByDocumentId(String id) {
        return documentDao.getEditionByDocumentId(id);
    }

    public String getNameByPersonId(String personId) {
        return documentDao.getNameByPersonId(personId);
    }

    public String getRoleByNodeId(String workflowId, String nodeId) {
        return documentDao.getRoleByNodeId(workflowId, nodeId);
    }

    public String getDeptByPersonId(String personId) {
        return documentDao.getDeptByPersonId(personId);
    }

    public String getHandleRole(String roleId) {
        return documentDao.getHandleRole(roleId);
    }

    @Override
    public String getDocumentHandleById2(String id, String roleName) {
        return documentDao.getDocumentHandleById2(id, roleName);
    }

    public Start getStartByBusinessId(String id) {
        return documentDao.getStartByBusinessId(id);
    }

    public List<Document> getRequestFlagById(String id) {
        return documentDao.getRequestFlagById(id);
    }
}
