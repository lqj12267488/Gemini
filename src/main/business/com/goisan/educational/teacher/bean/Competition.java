package com.goisan.educational.teacher.bean;

import com.goisan.system.bean.BaseBean;

/**
 * 业务竞赛
 */
public class Competition  extends BaseBean {

    private String competitionId;
    private String competitionProject; //竞赛项目
    private String competitionGroup;//竞赛组别
    private String competitionLevel;//竞赛级别
    private String hostUnit;//主办单位
    private String score;//比赛成绩

    public String getCompetitionId() {
        return competitionId;
    }

    public void setCompetitionId(String competitionId) {
        this.competitionId = competitionId;
    }

    public String getCompetitionProject() {
        return competitionProject;
    }

    public void setCompetitionProject(String competitionProject) {
        this.competitionProject = competitionProject;
    }

    public String getCompetitionGroup() {
        return competitionGroup;
    }

    public void setCompetitionGroup(String competitionGroup) {
        this.competitionGroup = competitionGroup;
    }

    public String getCompetitionLevel() {
        return competitionLevel;
    }

    public void setCompetitionLevel(String competitionLevel) {
        this.competitionLevel = competitionLevel;
    }

    public String getHostUnit() {
        return hostUnit;
    }

    public void setHostUnit(String hostUnit) {
        this.hostUnit = hostUnit;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }
}
