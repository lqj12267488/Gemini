package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.HallUse;
import com.goisan.synergy.workflow.bean.Standard;
import com.goisan.synergy.workflow.dao.HallUseDao;
import com.goisan.synergy.workflow.service.HallUseService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**礼堂使用管理
 * Created by wq on 2017/7/18.
 */
@Service
public class HallUseServiceImpl implements HallUseService{
    @Resource
    private HallUseDao hallUseDao;

    public List<HallUse> getHallUseList(HallUse hallUse) {
        return hallUseDao.getHallUseList(hallUse);
    }

    public void insertHallUse(HallUse hallUse) {
        hallUseDao.insertHallUse(hallUse);
    }

    public void updateHallUseAPP(HallUse hallUse) {
        hallUseDao.updateHallUseAPP(hallUse);
    }

    public void deleteHallUse(String id) {
        hallUseDao.deleteHallUse(id);
    }

    public void updateHallUse(HallUse hallUse) {
        hallUseDao.updateHallUse(hallUse);
    }

    public HallUse getHallUseById(String id) {
        return hallUseDao.getHallUseById(id);
    }

    public List<HallUse> getHallUseProcessList(HallUse hallUse) {
        return hallUseDao.getHallUseProcessList(hallUse);
    }

    public List<HallUse> getHallUseCompleteList(HallUse hallUse) {
        return hallUseDao.getHallUseCompleteList(hallUse);
    }

    public List<AutoComplete> selectPerson() {
        return hallUseDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return hallUseDao.selectDept();
    }

    public String getPersonNameById(String personId) {
        return  hallUseDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return hallUseDao.getDeptNameById(deptId);
    }

    public List<Select2> getDeptPerson(String deptId) {
        return hallUseDao.getDeptPerson(deptId);
    }

    public Standard getHallUseStandard(Standard standard){ return hallUseDao.getHallUseStandard(standard);}

    public void insertHallUseStandard(Standard standard) {
        hallUseDao.insertHallUseStandard(standard);
    }

    public void updateHallUseStandard(Standard standard){
        hallUseDao.updateHallUseStandard(standard);
    }
}
