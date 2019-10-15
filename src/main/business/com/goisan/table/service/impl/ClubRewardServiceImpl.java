package com.goisan.table.service.impl;

import com.goisan.table.dao.ClubRewardDao;
import com.goisan.table.service.ClubRewardService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ClubRewardServiceImpl implements ClubRewardService {

    @Resource
    private ClubRewardDao clubRewardDao;

    @Override
    public List<BaseBean> getClubRewardList(BaseBean baseBean) {
        return clubRewardDao.getClubRewardList(baseBean);
    }

    @Override
    public void saveClubReward(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        clubRewardDao.saveClubReward(baseBean);
    }

    @Override
    public BaseBean getClubRewardById(String id) {
        return clubRewardDao.getClubRewardById(id);
    }

    @Override
    public void updateClubReward(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        clubRewardDao.updateClubReward(baseBean);
    }

    @Override
    public void delClubReward(String id) {
        clubRewardDao.delClubReward(id);
    }
}
