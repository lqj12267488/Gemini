package com.goisan.educational.place.meetingRoom.service.impl;

import com.goisan.educational.place.meetingRoom.bean.MeetingRoom;
import com.goisan.educational.place.meetingRoom.dao.MeetingRoomDao;
import com.goisan.educational.place.meetingRoom.service.MeetingRoomService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/7/14.
 */
@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
    @Resource
    private MeetingRoomDao meetingRoomDao;
    public List<MeetingRoom> getMeetingRoomList(String id){return meetingRoomDao.getMeetingRoomList(id);}
    public void insertMeetingRoom(MeetingRoom meetingRoom){meetingRoomDao.insertMeetingRoom(meetingRoom);}
    public List<MeetingRoom> meetingRoomAction(MeetingRoom meetingRoom){return meetingRoomDao.meetingRoomAction(meetingRoom);}
    public MeetingRoom getMeetingRoomById(String id){return meetingRoomDao.getMeetingRoomById(id);}
    public void updateMeetingRoomById(MeetingRoom meetingRoom){meetingRoomDao.updateMeetingRoomById(meetingRoom);}
    public void deleteMeetingRoomById(String id){meetingRoomDao.deleteMeetingRoomById(id);}
    public List<AutoComplete> selectDept(){ return meetingRoomDao.selectDept();}
    public List<AutoComplete> selectPerson(){return meetingRoomDao.selectPerson();}
    public String getPersonNameById(String id){ return meetingRoomDao.getPersonNameById(id);}
    public String getDeptNameById(String id){ return meetingRoomDao.getDeptNameById(id);}
    public List<MeetingRoom> checkName(MeetingRoom meetingRoom) {
        return meetingRoomDao.checkName(meetingRoom);
    }

}
