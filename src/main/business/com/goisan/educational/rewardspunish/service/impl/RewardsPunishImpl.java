package com.goisan.educational.rewardspunish.service.impl;

import com.goisan.educational.rewardspunish.bean.Punish;
import com.goisan.educational.rewardspunish.bean.Rewards;
import com.goisan.educational.rewardspunish.bean.RewardsPunish;
import com.goisan.educational.rewardspunish.dao.RewardsPunishDao;
import com.goisan.educational.rewardspunish.service.RewardsPunishService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
@Service
public class RewardsPunishImpl implements RewardsPunishService{
    @Resource
    private RewardsPunishDao rewardsPunishDao;
    public List<Rewards> rewardsAction(Rewards rewards) {
        return rewardsPunishDao.rewardsAction(rewards);
    }

    public void insertRewards(Rewards rewards) {
        rewardsPunishDao.insertRewards(rewards);
    }

    public void deleteRewardsById(String id) {
        rewardsPunishDao.deleteRewardsById(id);
    }

    public Rewards getRewardsById(String id) {
        return rewardsPunishDao.getRewardsById(id);
    }

    public void updateRewardsById(Rewards rewards) {
        rewardsPunishDao.updateRewardsById(rewards);
    }

    public List<Punish> punishAction(Punish punish) {
        return rewardsPunishDao.punishAction(punish);
    }

    public void deletePunishById(String id) {
        rewardsPunishDao.deletePunishById(id);
    }

    public Punish getPunishById(String id) {
        return rewardsPunishDao.getPunishById(id);
    }

    public void updatePunishById(Punish punish) {
        rewardsPunishDao.updatePunishById(punish);
    }

    public void insertPunish(Punish punish) {
        rewardsPunishDao.insertPunish(punish);
    }

    public List<RewardsPunish> rewardsPunishAction(RewardsPunish rewardsPunish) {
        return rewardsPunishDao.rewardsPunishAction(rewardsPunish);
    }

    public List<RewardsPunish> personalRewardsPunishList(RewardsPunish rewardsPunish) {
        return rewardsPunishDao.personalRewardsPunishList(rewardsPunish);
    }
}
