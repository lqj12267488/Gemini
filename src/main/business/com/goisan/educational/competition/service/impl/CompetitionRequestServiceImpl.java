package com.goisan.educational.competition.service.impl;

import com.goisan.educational.competition.bean.CompetitionRequest;
import com.goisan.educational.competition.dao.CompetitionRequestDao;
import com.goisan.educational.competition.service.CompetitionRequestService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CompetitionRequestServiceImpl implements CompetitionRequestService{

    @Resource
    private CompetitionRequestDao competitionRequestDao;

    public List<CompetitionRequest> competitionRequestAction(CompetitionRequest competitionRequest){
        return competitionRequestDao.competitionRequestAction(competitionRequest);
    }

    public void deleteCompetitionRequestById(String id){
        competitionRequestDao.deleteCompetitionRequestById(id);
    }

    public CompetitionRequest getCompetitionRequestById(String id){
        return competitionRequestDao.getCompetitionRequestById(id);
    }

    public void updateCompetitionRequestById(CompetitionRequest competitionRequest){
        competitionRequestDao.updateCompetitionRequestById(competitionRequest);
    }

    public void insertCompetitionRequest(CompetitionRequest competitionRequest){
        competitionRequestDao.insertCompetitionRequest(competitionRequest);
    }

    public List<AutoComplete> autoCompleteCompetition(){
        return competitionRequestDao.autoCompleteCompetition();
    }

    public List<Select2> getCompetitionProjectSelect(){
        return competitionRequestDao.getCompetitionProjectSelect();
    }
}
