package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.MealCardReissue;
import com.goisan.synergy.workflow.dao.MealCardReissueDao;
import com.goisan.synergy.workflow.service.MealCardReissueService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/10/11.
 */
@Service
public class MealCardReissueServiceImpl  implements MealCardReissueService {
    @Resource
    private MealCardReissueDao mealCardReissueDao;
    public List<MealCardReissue> getMealCardReissueList(MealCardReissue mealCardReissue){
        return mealCardReissueDao.getMealCardReissueList(mealCardReissue);
    }
    public void insertMealCardReissue(MealCardReissue mealCardReissue){
        mealCardReissueDao.insertMealCardReissue(mealCardReissue);
    }
    public MealCardReissue getMealCardReissueById(String id){
        return mealCardReissueDao.getMealCardReissueById(id);
    }
    public void updateMealCardReissueById(MealCardReissue mealCardReissue){
        mealCardReissueDao.updateMealCardReissueById(mealCardReissue);
    }
    public void deleteMealCardReissueById(String id){
        mealCardReissueDao.deleteMealCardReissueById(id);
    }
    public List<AutoComplete> autoCompleteDept(){
        return mealCardReissueDao.autoCompleteDept();
    }
    public List<AutoComplete> autoCompleteEmployee(){
        return mealCardReissueDao.autoCompleteEmployee();
    }
    public List<MealCardReissue> getProcessList(MealCardReissue mealCardReissue){
        return mealCardReissueDao.getProcessList(mealCardReissue);
    }
    public List<MealCardReissue> getCompleteList(MealCardReissue mealCardReissue){
        return mealCardReissueDao.getCompleteList(mealCardReissue);
    }
    public String getPersonNameById(String personId){
        return mealCardReissueDao.getPersonNameById(personId);
    }
    public String getDeptNameById(String deptId){
        return mealCardReissueDao.getDeptNameById(deptId);
    }

}
