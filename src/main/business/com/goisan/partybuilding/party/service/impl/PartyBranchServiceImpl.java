package com.goisan.partybuilding.party.service.impl;

import com.goisan.partybuilding.party.bean.PartyBranch;
import com.goisan.partybuilding.party.dao.PartyBranchDao;
import com.goisan.partybuilding.party.service.PartyBranchService;
import org.springframework.stereotype.Service;


import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/26/026.
 */
@Service
public class PartyBranchServiceImpl implements PartyBranchService {
    @Resource
    private PartyBranchDao partyBranchDao;

    public List<PartyBranch> partyBranchAction(PartyBranch partyBranch) {
        return partyBranchDao.partyBranchAction(partyBranch);
    }

    public void insertPartyBranch(PartyBranch partyBranch) {
        partyBranchDao.insertPartyBranch(partyBranch);
    }

    public List checkName(PartyBranch partyBranch) {
        return partyBranchDao.checkName(partyBranch);
    }

    public PartyBranch getPartyBranchById(String id) {
        return partyBranchDao.getPartyBranchById(id);
    }


    public void updatePartyBranch(PartyBranch partyBranch) {
        partyBranchDao.updatePartyBranch(partyBranch);
    }

    public void deletePartyBranchById(String id) {
        partyBranchDao.deletePartyBranchById(id);
    }

    public List<PartyBranch> searchPartyBranchList(PartyBranch partyBranch) {
        return partyBranchDao.searchPartyBranchList(partyBranch);
    }

    public List isExistInParty(String id) {
        return partyBranchDao.isExistInParty(id);
    }
}
