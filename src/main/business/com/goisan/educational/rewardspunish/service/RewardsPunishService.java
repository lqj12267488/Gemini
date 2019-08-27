package com.goisan.educational.rewardspunish.service;

import com.goisan.educational.rewardspunish.bean.Punish;
import com.goisan.educational.rewardspunish.bean.Rewards;
import com.goisan.educational.rewardspunish.bean.RewardsPunish;
import com.goisan.synergy.workflow.bean.AssetsScrap;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
public interface RewardsPunishService {
    List<Rewards> rewardsAction(Rewards rewards);
    void insertRewards(Rewards rewards);
    void deleteRewardsById(String id);
    Rewards getRewardsById(String id);
    void updateRewardsById(Rewards rewards);

    List<Punish> punishAction(Punish punish);
    void deletePunishById(String id);
    Punish getPunishById(String id);
    void updatePunishById(Punish punish);
    void insertPunish(Punish punish);

    List<RewardsPunish> rewardsPunishAction(RewardsPunish rewardsPunish);
    List<RewardsPunish> personalRewardsPunishList(RewardsPunish rewardsPunish);
}
