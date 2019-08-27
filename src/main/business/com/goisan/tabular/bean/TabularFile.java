package com.goisan.tabular.bean;

import com.goisan.system.bean.BaseBean;

public class TabularFile extends BaseBean {
    private String fileId;
    private String tabularId;
    private String fileName;
    private String fileUrl;
    private String fileSuffix;
    private String fileSize;
    private String coverUrl;
    private String coverType;
    private String isTranscoding;
    private String fileState;
    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public String getTabularId() {
        return tabularId;
    }

    public void setTabularId(String tabularId) {
        this.tabularId = tabularId;
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

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public String getCoverType() {
        return coverType;
    }

    public void setCoverType(String coverType) {
        this.coverType = coverType;
    }

    public String getIsTranscoding() {
        return isTranscoding;
    }

    public void setIsTranscoding(String isTranscoding) {
        this.isTranscoding = isTranscoding;
    }

    public String getFileState() {
        return fileState;
    }

    public void setFileState(String fileState) {
        this.fileState = fileState;
    }
}
