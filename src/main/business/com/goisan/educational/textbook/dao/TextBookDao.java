package com.goisan.educational.textbook.dao;

import com.goisan.educational.textbook.bean.*;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;

import java.util.List;
import java.util.Map;

public interface TextBookDao {
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

    void insertTextbookDeclareLog(TextBookDeclare textBookDeclare);

    List<TextBookDeclare> getFaFang(TextBookDeclare textBookDeclare);

    List<TextBookStatistics> textBookPaymentList(TextBookStatistics textBookStatistics);

    List<Map<String, String>> getDeptList();

    List<Map<String, Object>> getClassesByDeptId(String deptId);

    List<TextBookStatistics> getResult(String classId);

    /**
     * 通过教材名称获取单价
     * @param textbookId
     * @return
     */
    TextBook getUnitPriceByTextbookId(String textbookId);

    void updateTextBookDeclareDiscount(TextBookDeclare textBookDeclare);

    void updateTextBookDeclareActualNum(TextBookDeclare textBookDeclare);

    /**
     * 订购日志新增
     * @param textBookOrderLog
     */
    void insertTextbookOrderLog(TextBookOrderLog textBookOrderLog);

    /**
     * 订购日志修改
     * @param textBookOrderLog
     */
    void updateTextbookOrderLog(TextBookOrderLog textBookOrderLog);

    /**
     * 获取教材发放记录
     * @return
     */
    List<TextBookDeclare> getGrantList(String declareId);

    /**
     * 教材发放统计数据
     * @param textBookStatistics
     * @return
     */
    List<TextBookStatistics> textBookGrantStatisticsList(TextBookStatistics textBookStatistics);
    /**
     * 获取班级人数
     */
    String  getStudentByClassId(String classId);

    /**
     * 教材新增校验
     */
    List<TextBook> getTextBookByTextBook(TextBook textBook);

    /**
     * 教材申报删除校验
     */
    List<TextBookDeclare> getTextBookDeclareByDeclareId(String id);

    void updateTextBookDeclareRemainderNum(TextBookDeclare textBookDeclare);
}
