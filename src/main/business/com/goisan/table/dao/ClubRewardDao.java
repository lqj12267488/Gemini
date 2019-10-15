package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ClubRewardDao {

    List<BaseBean> getClubRewardList(BaseBean baseBean);

    void saveClubReward(BaseBean baseBean);

    BaseBean getClubRewardById(String id);

    void updateClubReward(BaseBean baseBean);

    void delClubReward(String id);

}
