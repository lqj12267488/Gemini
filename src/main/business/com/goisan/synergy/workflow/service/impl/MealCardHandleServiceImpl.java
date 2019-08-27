package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.MealCardHandle;
import com.goisan.synergy.workflow.dao.MealCardHandleDao;
import com.goisan.synergy.workflow.service.MealCardHandleService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/10/10.
 */
@Service
public class MealCardHandleServiceImpl implements MealCardHandleService{
    @Resource
    private MealCardHandleDao mealCardHandleDao;
    public List<MealCardHandle> getMealCardHandleList(MealCardHandle mealCardHandle){
        return mealCardHandleDao.getMealCardHandleList(mealCardHandle);
    }
    public void insertMealCardHandle(MealCardHandle mealCardHandle){
        mealCardHandleDao.insertMealCardHandle(mealCardHandle);
    }
    public MealCardHandle getMealCardHandleById(String id){
        return mealCardHandleDao.getMealCardHandleById(id);
    }
    public void updateMealCardHandleById(MealCardHandle mealCardHandle){
        mealCardHandleDao.updateMealCardHandleById(mealCardHandle);
    }
    public void deleteMealCardHandleById(String id){
        mealCardHandleDao.deleteMealCardHandleById(id);
    }
    public List<AutoComplete> autoCompleteDept(){
        return mealCardHandleDao.autoCompleteDept();
    }
    public List<AutoComplete> autoCompleteEmployee(){
        return mealCardHandleDao.autoCompleteEmployee();
    }
    public List<MealCardHandle> getProcessList(MealCardHandle mealCardHandle){
        return mealCardHandleDao.getProcessList(mealCardHandle);
    }
    public List<MealCardHandle> getCompleteList(MealCardHandle mealCardHandle){
        return mealCardHandleDao.getCompleteList(mealCardHandle);
    }
    public String getPersonNameById(String personId){
        return mealCardHandleDao.getPersonNameById(personId);
    }
    public String getDeptNameById(String deptId){
        return mealCardHandleDao.getDeptNameById(deptId);
    }
}
