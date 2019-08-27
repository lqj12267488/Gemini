package com.goisan.educational.place.meetingRoom.dao;

import com.goisan.educational.place.meetingRoom.bean.MeetingRoom;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;

import java.util.List;

/**
 * Created by hanyu on 2017/7/14.
 */
public interface MeetingRoomDao {
    List<MeetingRoom> getMeetingRoomList(String id);
    void insertMeetingRoom(MeetingRoom meetingRoom);
    List<MeetingRoom> meetingRoomAction(MeetingRoom meetingRoom);
    MeetingRoom getMeetingRoomById(String id);
    void updateMeetingRoomById(MeetingRoom meetingRoom);
    void deleteMeetingRoomById(String id);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    String getPersonNameById(String id);
    String getDeptNameById(String id);
    List<MeetingRoom> checkName(MeetingRoom meetingRoom);

}
