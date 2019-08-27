package com.goisan.educational.place.dorm.service.impl;

import com.goisan.educational.place.dorm.bean.Dorm;
import com.goisan.educational.place.dorm.dao.DormDao;
import com.goisan.educational.place.dorm.service.DormService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**寝室场地维护
 * Created by wq on 2017/7/15.
 */
@Service
public class DormServiceImpl implements DormService{
    @Resource
    DormDao dormDao;
    public List<Dorm> getDormList(Dorm dorm){
        return dormDao.getDormList(dorm);
    }

    public Dorm getDormById(String id){
        return dormDao.getDormById(id);
    }
    public void insertDorm(Dorm dorm){
        dormDao.insertDorm(dorm);
    }
    public void updateDorm(Dorm dorm){
        dormDao.updateDorm(dorm);
    }
    public void deleteDorm(String id){
        dormDao.deleteDorm(id);
    }
    public List<AutoComplete> getPersonNameById(){
        return dormDao.getPersonNameById();
    }
    public List<AutoComplete> getDeptNameById(){
        return dormDao.getDeptNameById();
    }
    public List<Dorm> checkName(Dorm dorm) {
        return dormDao.checkName(dorm);
    }
    public List<AutoComplete> selectDormName()  {
        return dormDao.selectDormName();
    }
    public List<String> checkApplyStudent(String id){return dormDao.checkApplyStudent(id);}
}
