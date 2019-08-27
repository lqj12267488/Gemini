package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Hallsoundroom;
import com.goisan.synergy.workflow.dao.HallsoundroomDao;
import com.goisan.synergy.workflow.service.HallsoundroomService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/6.
 */
@Service
public class HallsoundroomServiceImpl implements HallsoundroomService {
    @Resource
    private HallsoundroomDao hallsoundroomDao;

    public List<Hallsoundroom> hallsoundroomAction(Hallsoundroom hallsoundroom) {
        return hallsoundroomDao.hallsoundroomAction(hallsoundroom);
    }

    public void insertHallsoundroom(Hallsoundroom hallsoundroom) {
        hallsoundroomDao.insertHallsoundroom(hallsoundroom);
    }

    public Hallsoundroom getHallsoundroomById(String id) {
        return hallsoundroomDao.getHallsoundroomById(id);
    }

    public void updateHallsoundroom(Hallsoundroom hallsoundroom) {
        hallsoundroomDao.updateHallsoundroom(hallsoundroom);
    }
    public void deleteHallsoundroomById(String id) {
        hallsoundroomDao.deleteHallsoundroomById(id);
    }


    public List<Hallsoundroom> searchhallsoundroom(Hallsoundroom hallsoundroom) {
        return hallsoundroomDao.searchhallsoundroom(hallsoundroom);
    }



    public List<AutoComplete> selectDept()  {
        return hallsoundroomDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return hallsoundroomDao.selectPerson();
    }

    public List<Hallsoundroom> getProcessHallsoundroomList(Hallsoundroom hallsoundroom) {
        return hallsoundroomDao.getProcessHallsoundroomList(hallsoundroom);
    }

    public List<Hallsoundroom> getCompleteHallsoundroomList(Hallsoundroom hallsoundroom) {
        return hallsoundroomDao.getCompleteHallsoundroomList(hallsoundroom);
    }
    public String getPersonNameById(String personId) {
        return hallsoundroomDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return hallsoundroomDao.getDeptNameById(deptId);
    }
}
