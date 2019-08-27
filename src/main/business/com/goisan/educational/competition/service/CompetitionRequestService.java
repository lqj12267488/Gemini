package com.goisan.educational.competition.service;

import com.goisan.educational.competition.bean.CompetitionRequest;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;

import java.util.List;

public interface CompetitionRequestService {

    List<CompetitionRequest> competitionRequestAction(CompetitionRequest competitionRequest);

    void deleteCompetitionRequestById(String id);

    CompetitionRequest getCompetitionRequestById(String id);

    void updateCompetitionRequestById(CompetitionRequest competitionRequest);

    void insertCompetitionRequest(CompetitionRequest competitionRequest);

    List<AutoComplete> autoCompleteCompetition();

    List<Select2> getCompetitionProjectSelect();
}
