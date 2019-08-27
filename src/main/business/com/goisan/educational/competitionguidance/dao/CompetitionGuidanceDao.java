package com.goisan.educational.competitionguidance.dao;

import com.goisan.educational.competitionguidance.bean.CompetitionGuidance;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CompetitionGuidanceDao {

    List<CompetitionGuidance> getCompetitionGuidanceList(CompetitionGuidance guidance);

    CompetitionGuidance getCompetitionGuidanceById(String id);

    void addCompetitionGuidance(CompetitionGuidance guidance);

    void delCompetitionGuidance(String guidance);

    void updateCompetitionGuidance(CompetitionGuidance guidance);
}
