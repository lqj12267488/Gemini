package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.MealCardHandle;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/10/10.
 */
public interface MealCardHandleService {
    List<MealCardHandle> getMealCardHandleList(MealCardHandle mealCardHandle);
    void insertMealCardHandle(MealCardHandle mealCardHandle);
    MealCardHandle getMealCardHandleById(String id);
    void updateMealCardHandleById(MealCardHandle mealCardHandle);
    void deleteMealCardHandleById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<MealCardHandle> getProcessList(MealCardHandle mealCardHandle);
    List<MealCardHandle> getCompleteList(MealCardHandle mealCardHandle);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
}
