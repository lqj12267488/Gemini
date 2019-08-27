package com.goisan.educational.rewardspunish.service.impl;

import com.goisan.educational.rewardspunish.bean.Punish;
import com.goisan.educational.rewardspunish.bean.Rewards;

import com.goisan.educational.rewardspunish.bean.RewardsPunishSearch;
import com.goisan.educational.rewardspunish.dao.RewardsPunishSearchDao;
import com.goisan.educational.rewardspunish.service.RewardsPunishSearchService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
@Service
public class RewardsPunishSearchImpl implements RewardsPunishSearchService {
    @Resource
    private RewardsPunishSearchDao rewardsPunishSearchDao;
    public List<Rewards> rewardsAction(Rewards rewards) {
        return rewardsPunishSearchDao.rewardsAction(rewards);
    }

    public void insertRewards(Rewards rewards) {
        rewardsPunishSearchDao.insertRewards(rewards);
    }

    public void deleteRewardsById(String id) {
        rewardsPunishSearchDao.deleteRewardsById(id);
    }

    public Rewards getRewardsById(String id) {
        return rewardsPunishSearchDao.getRewardsById(id);
    }

    public void updateRewardsById(Rewards rewards) {
        rewardsPunishSearchDao.updateRewardsById(rewards);
    }

    public List<Punish> punishAction(Punish punish) {
        return rewardsPunishSearchDao.punishAction(punish);
    }

    public void deletePunishById(String id) {
        rewardsPunishSearchDao.deletePunishById(id);
    }

    public Punish getPunishById(String id) {
        return rewardsPunishSearchDao.getPunishById(id);
    }

    public void updatePunishById(Punish punish) {
        rewardsPunishSearchDao.updatePunishById(punish);
    }

    public void insertPunish(Punish punish) {
        rewardsPunishSearchDao.insertPunish(punish);
    }

    public List<RewardsPunishSearch> rewardsPunishActionSearch(RewardsPunishSearch rewardsPunishSearch) {
        return rewardsPunishSearchDao.rewardsPunishActionSearch(rewardsPunishSearch);
    }

}
