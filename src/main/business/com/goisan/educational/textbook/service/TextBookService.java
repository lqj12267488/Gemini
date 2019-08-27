package com.goisan.educational.textbook.service;

import com.goisan.educational.textbook.bean.*;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;

import java.util.List;
import java.util.Map;

public interface TextBookService {

    List<AutoComplete> getTextBookAll();

    List getTextBookList(TextBook textBook);

    void saveTextBook(TextBook textBook);

    void saveActualNum(TextBookDeclare textBookDeclare);

    TextBook getTextBookById(String id);

    void updateTextBook(TextBook textBook);

    void delTextBook(String id);

    List<Select2> getMajorByDeptId(String deptId);

    List<TextBookPlan> textBookPlanList(TextBookPlan textBookPlan);

    void insertTextBookPlan(TextBookPlan textBookPlan);

    void deleteTextBookPlanById(String id);

    List isExistInTextBookPlan(String id);

    void updateTextBookPlan(TextBookPlan textBookPlan);

    TextBookPlan getTextBookPlanById(String id);

    List<TextBookDeclare> textBookDeclareList(TextBookDeclare textBookDeclare);

    TextBookDeclare getTextBookDeclareById(String id);

    TextBookDeclare getTextBookDeclare(TextBookDeclare textBookDeclare);

    void insertTextBookDeclare(TextBookDeclare textBookDeclare);

    void updateTextBookDeclare(TextBookDeclare textBookDeclare);

    void deleteTextBookDeclareById(String id);

    List<Select2> getMajorByMajorPrincipal(String majorPrincipal);

    void submitTextBookDeclareById(String id);

    void updateTextBookRelease(TextBookLog textBookLog);

    TextBook getTextBookNumInById(String textbookId);

    void updateTextBookNumIn(TextBook tb);

    TextBookPlan checkTextbookPlanByTime(String textbookPlanId);

    List<TextBookDeclare> getTextBookReleaseList(TextBookDeclare textBookDeclare);

    void updateTextBookRemainderNum(TextBookDeclare textBookDeclare);

    List isExistInTextBook(String id);

    List<TextBookStatistics> searchTextbookIsExist(TextBookStatistics textBookStatistics);

    void insertTextBookStatistics(TextBookStatistics textBookStatistics);

    void statisticsTextbookByTextbookId(TextBookStatistics textBookStatistics);

    List<TextBookStatistics> textBookStatisticsList(TextBookStatistics textBookStatistics);

    List<TextBookStatistics> getTextbookPaymentList(TextBookStatistics textBookStatistics);

    List<TextBookStatistics> getPaymentList(TextBookStatistics textBookStatistics);

    TextBookStatistics getTextBookStatisticsById(String id);

    void updateTextBookStatistics(TextBookStatistics textBookStatistics);

    List<TextBookDeclare> getTextBookReleaseStatisticsList(TextBookDeclare textBookDeclare);

    String getUserTypeByPersonId(String id);

    void updateDeclareNum(TextBookDeclare textBookDeclare);

    List<TextBookDeclare> getFaFang(TextBookDeclare textBookDeclare);

    void insertTextbookDeclareLog(TextBookDeclare textBookDeclare);

    List<TextBookStatistics> textBookPaymentList(TextBookStatistics textBookStatistics);

    List<Map<String, String>> getDeptList();

    List<Map<String, Object>> getClassesByDeptId(String deptId);

    List<TextBookStatistics> getResult(String classId);

    TextBook getUnitPriceByTextbookId(String textbookId);

    void updateTextBookDeclareDiscount(TextBookDeclare textBookDeclare);

    void updateTextBookDeclareActualNum(TextBookDeclare textBookDeclare);

    void insertTextbookOrderLog(TextBookOrderLog textBookOrderLog);

    void updateTextbookOrderLog(TextBookOrderLog textBookOrderLog);

    List<TextBookDeclare> getGrantList(String declareId);

    List<TextBookStatistics> textBookGrantStatisticsList(TextBookStatistics textBookStatistics);

    String  getStudentByClassId(String classId);

    List<TextBook> getTextBookByTextBook(TextBook textBook);

    List<TextBookDeclare> getTextBookDeclareByDeclareId(String id);

    void updateTextBookDeclareRemainderNum(TextBookDeclare textBookDeclare);
}
