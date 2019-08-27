package com.goisan.leaguebuilding.leaguebranch.service;
import com.goisan.leaguebuilding.leaguebranch.bean.LeagueBranch;
import com.goisan.system.bean.Tree;

import java.util.List;

/**
 * Created by Administrator on 2017/7/26/026.
 */
public interface LeagueBranchService {

    LeagueBranch getLeagueBranchById(String id);

    List<Tree> getLeagueBranchTree();

    String getNewLeagueBranchId(String pId);

    void saveLeagueBranch(LeagueBranch leagueBranch);

    void deleteLeagueBranchById(String id);

    void updateLeagueBranch(LeagueBranch leagueBranch);

    List<LeagueBranch> checkLeagueBranchById(String id);

    List isExistInLeague(String id);
}
