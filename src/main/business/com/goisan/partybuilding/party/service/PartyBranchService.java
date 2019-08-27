package com.goisan.partybuilding.party.service;

import com.goisan.partybuilding.party.bean.PartyBranch;

import java.util.List;

/**
 * Created by Administrator on 2017/7/26/026.
 */
public interface PartyBranchService {
    List<PartyBranch> partyBranchAction(PartyBranch partyBranch);

    void insertPartyBranch(PartyBranch partyBranch);

    List checkName(PartyBranch partyBranch);

    PartyBranch getPartyBranchById(String id);

    void updatePartyBranch(PartyBranch partyBranch);

    void deletePartyBranchById(String id);

    List<PartyBranch> searchPartyBranchList(PartyBranch partyBranch);

    List isExistInParty(String id);
}
