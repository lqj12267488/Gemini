package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.HotelStay;
import com.goisan.synergy.workflow.dao.HotelStayDao;
import com.goisan.synergy.workflow.service.HotelStayService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**学校商友酒店住宿管理
 * Created by wq on 2017/6/20.
 */
@Service
public class HotelStayServiceImpl implements HotelStayService{
    @Resource
    private HotelStayDao hotelStayDao;

    public List<HotelStay> getHotelStayList(HotelStay hotelStay) {
        return hotelStayDao.hotelStayAction(hotelStay);
    }

    public void insertHotelStay(HotelStay hotelStay) {
        hotelStayDao.insertHotelStay(hotelStay);
    }

    public void deleteHotelStayById(String id) {
        hotelStayDao.deleteHotelStayById(id);
    }

    public void updateHotelStayById(HotelStay hotelStay) {
        hotelStayDao.updateHotelStayById(hotelStay);
    }

    public HotelStay getHotelStayById(String id) {
        return hotelStayDao.getHotelStayById(id);
    }

    public List<HotelStay> getHotelStayListProcess(HotelStay hotelStay) {
        return hotelStayDao.getHotelStayListProcess(hotelStay);
    }
    public List<HotelStay> getHotelStayListComplete(HotelStay hotelStay) {
        return hotelStayDao.getHotelStayListComplete(hotelStay);
    }

    public String getPersonNameById(String personId) {
        return  hotelStayDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return hotelStayDao.getDeptNameById(deptId);
    }

    public List<AutoComplete> selectPerson() {
        return hotelStayDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return hotelStayDao.selectDept();
    }
}
