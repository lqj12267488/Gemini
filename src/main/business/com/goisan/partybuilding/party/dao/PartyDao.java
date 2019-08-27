package com.goisan.partybuilding.party.dao;

import com.goisan.partybuilding.party.bean.Party;
import com.goisan.partybuilding.party.bean.PartyBranch;
import com.goisan.partybuilding.party.bean.PartyMemberLog;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/7/26/026.
 */
@Repository
public interface PartyDao {

    List<Party> partyAction(Party party);

    Party getPartyById(String id);

    void insertParty(Party party);

    void updateParty(Party party);

    List checkName(Party party);

    void deletePartyById(String id);

    List<Party> searchPartyList(Party party);

    void updatePartyRolesById(Party party);

    Party selectPartyRolesById(String id);

    List<Party> getPartyByIds(@Param("ids") String ids);

    List<Party> getMembersRolesByIds(@Param("ids") String ids);

    void backPartyRolesById(Party party);

    void updateRelationshipByIds(Party party);

    Party getPartyDetailedById(String id);

    void insertPartyMemberLog(PartyMemberLog partyMemberLog);

    Party selectPartyById(String id);

    List getPartyLogByPersonId(String personId);
}
