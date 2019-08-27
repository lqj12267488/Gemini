package com.goisan.educational.competition.dao;

import com.goisan.educational.competition.bean.CompetitionRequest;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompetitionRequestDao {

    List<CompetitionRequest> competitionRequestAction(CompetitionRequest competitionRequest);

    void deleteCompetitionRequestById(String id);

    CompetitionRequest getCompetitionRequestById(String id);

    void updateCompetitionRequestById(CompetitionRequest competitionRequest);

    void insertCompetitionRequest(CompetitionRequest competitionRequest);

    List<AutoComplete> autoCompleteCompetition();

    List<Select2> getCompetitionProjectSelect();
}
