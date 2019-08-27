package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

public class DocumentProcess extends BaseBean {
    private String id;//主键id
    private String documentId;//公文id
    private String handleId;//工作流流程id
    private String edition;//版本
    private String fileName;//文件名称
    private String fileUrl;//文件所在路径，含文件路径、文件名称及后缀
    private String fileSuffix;//文件类型后缀
    private String fileSize;//文件大小

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDocumentId() {
        return documentId;
    }

    public void setDocumentId(String documentId) {
        this.documentId = documentId;
    }

    public String getHandleId() {
        return handleId;
    }

    public void setHandleId(String handleId) {
        this.handleId = handleId;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getFileSuffix() {
        return fileSuffix;
    }

    public void setFileSuffix(String fileSuffix) {
        this.fileSuffix = fileSuffix;
    }

    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }
}
