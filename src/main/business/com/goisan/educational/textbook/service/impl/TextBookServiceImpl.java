package com.goisan.educational.textbook.service.impl;

import com.goisan.educational.textbook.bean.*;
import com.goisan.educational.textbook.dao.TextBookDao;
import com.goisan.educational.textbook.service.TextBookService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class TextBookServiceImpl implements TextBookService {
    @Resource
    private TextBookDao textBookDao;

    @Override
    public List<AutoComplete> getTextBookAll() {
        return this.textBookDao.getTextBookAll();
    }

    public List getTextBookList(TextBook textBook) {
        return textBookDao.getTextBookList(textBook);
    }

    public void saveTextBook(TextBook textBook) {
        textBookDao.saveTextBook(textBook);
    }

    public void saveActualNum(TextBookDeclare textBookDeclare) {
        textBookDao.saveActualNum(textBookDeclare);
    }

    public TextBook getTextBookById(String id) {
        return textBookDao.getTextBookById(id);
    }

    public void updateTextBook(TextBook textBook) {
        textBookDao.updateTextBook(textBook);
    }

    public void delTextBook(String id) {
        textBookDao.delTextBook(id);
    }

    public List<Select2> getMajorByDeptId(String deptId) {
        return textBookDao.getMajorByDeptId(deptId);
    }

    public List<TextBookPlan> textBookPlanList(TextBookPlan textBookPlan) {
        return textBookDao.textBookPlanList(textBookPlan);
    }

    public void insertTextBookPlan(TextBookPlan textBookPlan) {
        textBookDao.insertTextBookPlan(textBookPlan);
    }

    public void deleteTextBookPlanById(String id) {
        textBookDao.deleteTextBookPlanById(id);
    }

    public List isExistInTextBookPlan(String id) {
        return textBookDao.isExistInTextBookPlan(id);
    }

    public void updateTextBookPlan(TextBookPlan textBookPlan) {
        textBookDao.updateTextBookPlan(textBookPlan);
    }

    public TextBookPlan getTextBookPlanById(String id) {
        return textBookDao.getTextBookPlanById(id);
    }

    public List<TextBookDeclare> textBookDeclareList(TextBookDeclare textBookDeclare) {
        return textBookDao.textBookDeclareList(textBookDeclare);
    }

    public TextBookDeclare getTextBookDeclareById(String id) {
        return textBookDao.getTextBookDeclareById(id);
    }

    public TextBookDeclare getTextBookDeclare(TextBookDeclare textBookDeclare) {
        return textBookDao.getTextBookDeclare(textBookDeclare);
    }

    public void insertTextBookDeclare(TextBookDeclare textBookDeclare) {
        textBookDao.insertTextBookDeclare(textBookDeclare);
    }

    public void updateTextBookDeclare(TextBookDeclare textBookDeclare) {
        textBookDao.updateTextBookDeclare(textBookDeclare);
    }

    public void deleteTextBookDeclareById(String id) {
        textBookDao.deleteTextBookDeclareById(id);
    }

    public List<Select2> getMajorByMajorPrincipal(String majorPrincipal) {
        return textBookDao.getMajorByMajorPrincipal(majorPrincipal);
    }

    public void submitTextBookDeclareById(String id) {
        textBookDao.submitTextBookDeclareById(id);
    }

    public void updateTextBookRelease(TextBookLog textBookLog) {
        textBookDao.updateTextBookRelease(textBookLog);
    }

    public TextBook getTextBookNumInById(String textbookId) {
        return textBookDao.getTextBookNumInById(textbookId);
    }

    public void updateTextBookNumIn(TextBook tb) {
        textBookDao.updateTextBookNumIn(tb);
    }

    public TextBookPlan checkTextbookPlanByTime(String textbookPlanId) {
        return textBookDao.checkTextbookPlanByTime(textbookPlanId);
    }

    public List<TextBookDeclare> getTextBookReleaseList(TextBookDeclare textBookDeclare) {
        return textBookDao.getTextBookReleaseList(textBookDeclare);
    }

    public void updateTextBookRemainderNum(TextBookDeclare textBookDeclare) {
        textBookDao.updateTextBookRemainderNum(textBookDeclare);
    }

    public List isExistInTextBook(String id) {
        return textBookDao.isExistInTextBook(id);
    }

    public List<TextBookStatistics> searchTextbookIsExist(TextBookStatistics textBookStatistics) {
        return textBookDao.searchTextbookIsExist(textBookStatistics);
    }

    public void insertTextBookStatistics(TextBookStatistics textBookStatistics) {
        textBookDao.insertTextBookStatistics(textBookStatistics);
    }

    public void statisticsTextbookByTextbookId(TextBookStatistics textBookStatistics) {
        textBookDao.statisticsTextbookByTextbookId(textBookStatistics);
    }

    public List<TextBookStatistics> textBookStatisticsList(TextBookStatistics textBookStatistics) {
        return textBookDao.textBookStatisticsList(textBookStatistics);
    }

    public List<TextBookStatistics> getTextbookPaymentList(TextBookStatistics textBookStatistics) {
        return textBookDao.getTextbookPaymentList(textBookStatistics);
    }

    public List<TextBookStatistics> getPaymentList(TextBookStatistics textBookStatistics) {
        return textBookDao.getPaymentList(textBookStatistics);
    }

    public TextBookStatistics getTextBookStatisticsById(String id) {
        return textBookDao.getTextBookStatisticsById(id);
    }

    public void updateTextBookStatistics(TextBookStatistics textBookStatistics) {
        textBookDao.updateTextBookStatistics(textBookStatistics);
    }

    public List<TextBookDeclare> getTextBookReleaseStatisticsList(TextBookDeclare textBookDeclare) {
        return textBookDao.getTextBookReleaseStatisticsList(textBookDeclare);
    }

    public String getUserTypeByPersonId(String id) {
        return textBookDao.getUserTypeByPersonId(id);
    }

    @Override
    public void updateDeclareNum(TextBookDeclare textBookDeclare) {
        textBookDao.updateDeclareNum(textBookDeclare);
    }

    @Override
    public List<TextBookDeclare> getFaFang(TextBookDeclare textBookDeclare) {
        return textBookDao.getFaFang(textBookDeclare);
    }

    @Override
    public void insertTextbookDeclareLog(TextBookDeclare textBookDeclare) {
        textBookDao.insertTextbookDeclareLog(textBookDeclare);
    }

    @Override
    public List<TextBookStatistics> textBookPaymentList(TextBookStatistics textBookStatistics) {
        return textBookDao.textBookPaymentList(textBookStatistics);
    }

    @Override
    public List<Map<String, String>> getDeptList() {
        return textBookDao.getDeptList();
    }

    @Override
    public List<Map<String, Object>> getClassesByDeptId(String deptId) {
        return textBookDao.getClassesByDeptId(deptId);
    }

    @Override
    public List<TextBookStatistics> getResult(String classId) {
        return textBookDao.getResult(classId);
    }

    public TextBook getUnitPriceByTextbookId(String textbookId){ return textBookDao.getUnitPriceByTextbookId(textbookId); }

    public void updateTextBookDeclareDiscount(TextBookDeclare textBookDeclare){ textBookDao.updateTextBookDeclareDiscount(textBookDeclare); }

    public void updateTextBookDeclareActualNum(TextBookDeclare textBookDeclare){ textBookDao.updateTextBookDeclareActualNum(textBookDeclare); }

    public void insertTextbookOrderLog(TextBookOrderLog textBookOrderLog){ textBookDao.insertTextbookOrderLog(textBookOrderLog); }

    public void updateTextbookOrderLog(TextBookOrderLog textBookOrderLog){ textBookDao.updateTextbookOrderLog(textBookOrderLog); }

    public List<TextBookDeclare> getGrantList(String declareId){ return textBookDao.getGrantList(declareId); }

    public List<TextBookStatistics> textBookGrantStatisticsList(TextBookStatistics textBookStatistics){ return textBookDao.textBookGrantStatisticsList(textBookStatistics); }

    public String  getStudentByClassId(String classId){ return textBookDao.getStudentByClassId(classId); }

    public List<TextBook> getTextBookByTextBook(TextBook textBook){ return textBookDao.getTextBookByTextBook(textBook); }

    public List<TextBookDeclare> getTextBookDeclareByDeclareId(String id){ return textBookDao.getTextBookDeclareByDeclareId(id); }

    public void updateTextBookDeclareRemainderNum(TextBookDeclare textBookDeclare){
        textBookDao.updateTextBookDeclareRemainderNum(textBookDeclare);
    }
}
