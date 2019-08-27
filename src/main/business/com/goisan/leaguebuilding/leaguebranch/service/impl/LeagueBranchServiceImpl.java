package com.goisan.leaguebuilding.leaguebranch.service.impl;

import com.goisan.leaguebuilding.leaguebranch.bean.LeagueBranch;
import com.goisan.leaguebuilding.leaguebranch.dao.LeagueBranchDao;
import com.goisan.leaguebuilding.leaguebranch.service.LeagueBranchService;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/26/026.
 */
@Service
public class LeagueBranchServiceImpl implements LeagueBranchService {
    @Resource
    private LeagueBranchDao leagueBranchDao;

    public LeagueBranch getLeagueBranchById(String id) {
        return leagueBranchDao.getLeagueBranchById(id);
    }

    public List<Tree> getLeagueBranchTree() {
        return leagueBranchDao.getLeagueBranchTree();
    }

    public String getNewLeagueBranchId(String pId) {
        String id = leagueBranchDao.getMaxId(pId);
        return CommonUtil.getnextId(id, pId);
    }
    public void saveLeagueBranch(LeagueBranch leagueBranch) {
        leagueBranchDao.saveLeagueBranch(leagueBranch);
    }

    public void deleteLeagueBranchById(String id) {
        leagueBranchDao.deleteLeagueBranchById(id);
    }


    public void updateLeagueBranch(LeagueBranch leagueBranch) {
        leagueBranchDao.updateLeagueBranch(leagueBranch);
    }

    @Override
    public List<LeagueBranch> checkLeagueBranchById(String id) {
        return leagueBranchDao.checkLeagueBranchById(id);
    }

    public List isExistInLeague(String id) {
        return leagueBranchDao.isExistInLeague(id);
    }
}
