package com.goisan.educational.competition.bean;

import com.goisan.system.bean.BaseBean;

public class CompetitionProject extends BaseBean{
    private String id;//主键id
    private String competitionProject;//竞赛项目
    private String competitionLevel;//竞赛级别字典(国家级,省级,市级,校级)
    private String competitionCompany;//主办单位
    private String year;//年份

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompetitionProject() {
        return competitionProject;
    }

    public void setCompetitionProject(String competitionProject) {
        this.competitionProject = competitionProject;
    }

    public String getCompetitionLevel() {
        return competitionLevel;
    }

    public void setCompetitionLevel(String competitionLevel) {
        this.competitionLevel = competitionLevel;
    }

    public String getCompetitionCompany() {
        return competitionCompany;
    }

    public void setCompetitionCompany(String competitionCompany) {
        this.competitionCompany = competitionCompany;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }
}
