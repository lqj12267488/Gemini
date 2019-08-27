package com.goisan.educational.competition.service.impl;

import com.goisan.educational.competition.bean.AwardWinning;
import com.goisan.educational.competition.dao.AwardWinningDao;
import com.goisan.educational.competition.service.AwardWinningService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AwardWinningServiceImpl implements AwardWinningService{
    @Resource
    private AwardWinningDao awardWinningDao;

    public List<AwardWinning> awardWinningAction(AwardWinning awardWinning){
        return awardWinningDao.awardWinningAction(awardWinning);
    }
    public void deleteAwardWinningById(String id){
        awardWinningDao.deleteAwardWinningById(id);
    }
    public AwardWinning getAwardWinningById(String id){
        return awardWinningDao.getAwardWinningById(id);
    }
    public void updateAwardWinningById(AwardWinning awardWinning){
        awardWinningDao.updateAwardWinningById(awardWinning);
    }
    public void insertAwardWinning(AwardWinning awardWinning){
        awardWinningDao.insertAwardWinning(awardWinning);
    }
}
