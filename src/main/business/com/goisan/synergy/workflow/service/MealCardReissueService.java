package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.MealCardReissue;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/10/11.
 */
public interface MealCardReissueService {
    List<MealCardReissue> getMealCardReissueList(MealCardReissue mealCardReissue);
    void insertMealCardReissue(MealCardReissue mealCardReissue);
    MealCardReissue getMealCardReissueById(String id);
    void updateMealCardReissueById(MealCardReissue mealCardReissue);
    void deleteMealCardReissueById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<MealCardReissue> getProcessList(MealCardReissue mealCardReissue);
    List<MealCardReissue> getCompleteList(MealCardReissue mealCardReissue);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
}
