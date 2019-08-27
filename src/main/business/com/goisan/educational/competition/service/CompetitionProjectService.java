package com.goisan.educational.competition.service;

import com.goisan.educational.competition.bean.AwardWinning;
import com.goisan.educational.competition.bean.CompetitionProject;

import java.util.List;

public interface CompetitionProjectService {

    List<CompetitionProject> competitionProjectAction(CompetitionProject competitionProject);

    void deleteCompetitionProjectById(String id);

    CompetitionProject getCompetitionProjectById(String id);

    void updateCompetitionProjectById(CompetitionProject competitionProject);

    void insertCompetitionProject(CompetitionProject competitionProject);

    List<AwardWinning> selectCompetitionProject(String id);
}
