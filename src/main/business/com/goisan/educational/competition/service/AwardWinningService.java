package com.goisan.educational.competition.service;

import com.goisan.educational.competition.bean.AwardWinning;

import java.util.List;

public interface AwardWinningService {
    List<AwardWinning> awardWinningAction(AwardWinning awardWinning);

    void deleteAwardWinningById(String id);

    AwardWinning getAwardWinningById(String id);

    void updateAwardWinningById(AwardWinning awardWinning);

    void insertAwardWinning(AwardWinning awardWinning);
}
