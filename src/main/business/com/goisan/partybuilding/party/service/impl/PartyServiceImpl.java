package com.goisan.partybuilding.party.service.impl;

import com.goisan.partybuilding.party.bean.Party;
import com.goisan.partybuilding.party.bean.PartyMemberLog;
import com.goisan.partybuilding.party.dao.PartyDao;
import com.goisan.partybuilding.party.service.PartyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/26/026.
 */
@Service
public class PartyServiceImpl implements PartyService {
    @Resource
    private PartyDao partyDao;

    public List<Party> partyAction(Party party) {
        return partyDao.partyAction(party);
    }

    public Party getPartyById(String id) {
        return partyDao.getPartyById(id);
    }

    public void insertParty(Party party) {
        partyDao.insertParty(party);
    }

    public void updateParty(Party party) {
        partyDao.updateParty(party);
    }

    public List checkName(Party party) {
        return partyDao.checkName(party);
    }

    public void deletePartyById(String id) {
        partyDao.deletePartyById(id);
    }

    public List<Party> searchPartyList(Party party) {
        return partyDao.searchPartyList(party);
    }

    public void updatePartyRolesById(Party party) {
        partyDao.updatePartyRolesById(party);
    }

    public Party selectPartyRolesById(String id) {
        return partyDao.selectPartyRolesById(id);
    }

    public List<Party> getPartyByIds(String ids) {
        return partyDao.getPartyByIds(ids);
    }

    public List<Party> getMembersRolesByIds(String ids) {
        return partyDao.getMembersRolesByIds(ids);
    }

    public void backPartyRolesById(Party party) {
        partyDao.backPartyRolesById(party);
    }

    public void updateRelationshipByIds(Party party) {
        partyDao.updateRelationshipByIds(party);
    }

    public Party getPartyDetailedById(String id) {
        return  partyDao.getPartyDetailedById(id);
    }

    public void insertPartyMemberLog(PartyMemberLog partyMemberLog) {
        partyDao.insertPartyMemberLog(partyMemberLog);
    }

    public Party selectPartyById(String id) {
        return partyDao.selectPartyById(id);
    }

    public List getPartyLogByPersonId(String personId) {
        return partyDao.getPartyLogByPersonId(personId);
    }
}
