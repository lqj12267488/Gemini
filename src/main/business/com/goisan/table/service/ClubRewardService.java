package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ClubRewardService {

    List<BaseBean> getClubRewardList(BaseBean baseBean);

    void saveClubReward(BaseBean baseBean);

    BaseBean getClubRewardById(String id);

    void updateClubReward(BaseBean baseBean);

    void delClubReward(String id);

}