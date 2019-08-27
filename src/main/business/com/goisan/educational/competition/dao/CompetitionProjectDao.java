package com.goisan.educational.competition.dao;

import com.goisan.educational.competition.bean.AwardWinning;
import com.goisan.educational.competition.bean.CompetitionProject;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompetitionProjectDao {

    List<CompetitionProject> competitionProjectAction(CompetitionProject competitionProject);

    void deleteCompetitionProjectById(String id);

    CompetitionProject getCompetitionProjectById(String id);

    void updateCompetitionProjectById(CompetitionProject competitionProject);

    void insertCompetitionProject(CompetitionProject competitionProject);

    List<AwardWinning> selectCompetitionProject(String id);

}
