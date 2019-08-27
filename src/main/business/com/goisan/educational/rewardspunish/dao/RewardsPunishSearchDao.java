package com.goisan.educational.rewardspunish.dao;

import com.goisan.educational.rewardspunish.bean.Punish;
import com.goisan.educational.rewardspunish.bean.Rewards;
import com.goisan.educational.rewardspunish.bean.RewardsPunishSearch;


import java.util.List;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
public interface RewardsPunishSearchDao {
    List<Rewards> rewardsAction(Rewards rewards);
    void deleteRewardsById(String id);
    Rewards getRewardsById(String id);
    void updateRewardsById(Rewards rewards);
    void insertRewards(Rewards rewards);

    List<Punish> punishAction(Punish punish);
    void deletePunishById(String id);
    Punish getPunishById(String id);
    void updatePunishById(Punish punish);
    void insertPunish(Punish punish);

    List<RewardsPunishSearch> rewardsPunishActionSearch(RewardsPunishSearch rewardsPunishSearch);
}
