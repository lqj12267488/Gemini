package com.goisan.synergy.workflow.dao;
import com.goisan.synergy.workflow.bean.SchoolCar;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;
/**学校车辆外出使用管理
 * Created and modify by wq on 2017/6/27 0027.
 */
@Repository
public interface SchoolCarDao {
    List<SchoolCar> getSchoolCarList(SchoolCar schoolCar);
    void insertSchoolCar(SchoolCar schoolCar);
    void deleteSchoolCarById(String id);
    void updateSchoolCarById(SchoolCar schoolCar);
    SchoolCar getSchoolCarById(String id);
    List<SchoolCar> getSchoolCarListProcess(SchoolCar schoolCar);
    List<SchoolCar> getSchoolCarListComplete(SchoolCar schoolCar);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<AutoComplete> selectPerson();
    List<AutoComplete> selectDept();
    List<SchoolCar> getSchoolCarRegisterList(SchoolCar schoolCar);
    List<SchoolCar> getSchoolCarConfirmList(SchoolCar schoolCar);
    void updateSchoolCarRegister(SchoolCar schoolCar);
    void updateSchoolCarConfirm(SchoolCar schoolCar);
}
