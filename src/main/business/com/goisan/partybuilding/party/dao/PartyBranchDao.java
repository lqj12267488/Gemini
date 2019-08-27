package com.goisan.partybuilding.party.dao;

import com.goisan.partybuilding.party.bean.PartyBranch;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/7/26/026.
 */
@Repository
public interface PartyBranchDao {
    List<PartyBranch> partyBranchAction(PartyBranch partyBranch);

    void insertPartyBranch(PartyBranch partyBranch);

    List checkName(PartyBranch partyBranch);

    void updatePartyBranch(PartyBranch partyBranch);

    PartyBranch getPartyBranchById(String id);

    void deletePartyBranchById(String id);

    List<PartyBranch> searchPartyBranchList(PartyBranch partyBranch);

    List isExistInParty(String id);
}
