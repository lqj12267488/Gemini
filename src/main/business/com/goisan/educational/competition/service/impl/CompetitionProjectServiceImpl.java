package com.goisan.educational.competition.service.impl;

import com.goisan.educational.competition.bean.AwardWinning;
import com.goisan.educational.competition.bean.CompetitionProject;
import com.goisan.educational.competition.dao.CompetitionProjectDao;
import com.goisan.educational.competition.service.CompetitionProjectService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CompetitionProjectServiceImpl implements CompetitionProjectService{
    @Resource
    private CompetitionProjectDao competitionProjectDao;

    public List<CompetitionProject> competitionProjectAction(CompetitionProject competitionProject){
        return competitionProjectDao.competitionProjectAction(competitionProject);
    }

    public void deleteCompetitionProjectById(String id){
        competitionProjectDao.deleteCompetitionProjectById(id);
    }

    public CompetitionProject getCompetitionProjectById(String id){
        return competitionProjectDao.getCompetitionProjectById(id);
    }

    public void updateCompetitionProjectById(CompetitionProject competitionProject){
        competitionProjectDao.updateCompetitionProjectById(competitionProject);
    }

    public void insertCompetitionProject(CompetitionProject competitionProject){
        competitionProjectDao.insertCompetitionProject(competitionProject);
    }

    public List<AwardWinning> selectCompetitionProject(String id){
        return competitionProjectDao.selectCompetitionProject(id);
    }
}
