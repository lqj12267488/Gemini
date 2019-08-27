package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.HotelStay;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**学校商友酒店住宿管理
 * Created by wq on 2017/6/20.
 */
public interface HotelStayService {
    List<HotelStay> getHotelStayList(HotelStay hotelStay);
    void insertHotelStay(HotelStay hotelStay);
    void deleteHotelStayById(String id);
    void updateHotelStayById(HotelStay hotelStay);
    HotelStay getHotelStayById(String id);
    List<HotelStay> getHotelStayListProcess(HotelStay hotelStay);
    List<HotelStay> getHotelStayListComplete(HotelStay hotelStay);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<AutoComplete> selectPerson();
    List<AutoComplete> selectDept();
}
