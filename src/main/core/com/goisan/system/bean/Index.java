package com.goisan.system.bean;

import java.util.List;

public class Index extends BaseBean {
    private String indexId;
    private String planId;
    private String indexName;
    private String parentIndexId;
    private Integer score;
    private Integer weights;
    private String indexLevel;
    private Integer colspan;
    private String leafFlag;

    public String getIndexLevel() {
        return indexLevel;
    }

    public void setIndexLevel(String indexLevel) {
        this.indexLevel = indexLevel;
    }

    public Integer getColspan() {
        return colspan;
    }

    public void setColspan(Integer colspan) {
        this.colspan = colspan;
    }

    public String getLeafFlag() {
        return leafFlag;
    }

    public void setLeafFlag(String leafFlag) {
        this.leafFlag = leafFlag;
    }

    private List<Index> indexList;

    public List<Index> getIndexList() {
        return indexList;
    }

    public void setIndexList(List<Index> indexList) {
        this.indexList = indexList;
    }

    public String getIndexId() {
        return indexId;
    }

    public void setIndexId(String indexId) {
        this.indexId = indexId;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    public String getParentIndexId() {
        return parentIndexId;
    }

    public void setParentIndexId(String parentIndexId) {
        this.parentIndexId = parentIndexId;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getWeights() {
        return weights;
    }

    public void setWeights(Integer weights) {
        this.weights = weights;
    }
}
