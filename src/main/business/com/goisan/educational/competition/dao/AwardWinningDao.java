package com.goisan.educational.competition.dao;

import com.goisan.educational.competition.bean.AwardWinning;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AwardWinningDao {
    List<AwardWinning> awardWinningAction(AwardWinning awardWinning);
    void deleteAwardWinningById(String id);
    AwardWinning getAwardWinningById(String id);
    void updateAwardWinningById(AwardWinning awardWinning);
    void insertAwardWinning(AwardWinning awardWinning);
}
