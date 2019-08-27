package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.HotelStay;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**学校商友酒店住宿管理
 * Created by Administrator on 2017/6/20.
 */
@Repository
public interface HotelStayDao {
    List<HotelStay> hotelStayAction(HotelStay hotelStay);
    void insertHotelStay(HotelStay hotelStay);
    void deleteHotelStayById(String id);
    void updateHotelStayById(HotelStay hotelStay);
    HotelStay getHotelStayById(String id);
    List<HotelStay> getHotelStayList(HotelStay hotelStay);
    List<HotelStay> getHotelStayListProcess(HotelStay hotelStay);
    List<HotelStay> getHotelStayListComplete(HotelStay hotelStay);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<AutoComplete> selectPerson();
    List<AutoComplete> selectDept();
}
