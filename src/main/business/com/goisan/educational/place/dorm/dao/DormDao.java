package com.goisan.educational.place.dorm.dao;

import com.goisan.educational.place.dorm.bean.Dorm;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**寝室场地维护
 * Created by wq on 2017/7/15.
 */
@Repository
public interface DormDao {
    List<Dorm> getDormList(Dorm dorm);
    Dorm getDormById(String id);
    void insertDorm(Dorm dorm);
    void updateDorm(Dorm dorm);
    void deleteDorm(String id);
    List<AutoComplete> getPersonNameById();
    List<AutoComplete> getDeptNameById();
    List<Dorm> checkName(Dorm dorm);
    List<AutoComplete> selectDormName();
    List<String> checkApplyStudent(String id);
}
