package com.goisan.educational.textbook.service.impl;

import com.goisan.educational.textbook.bean.TextBook;
import com.goisan.educational.textbook.bean.TextBookDeclare;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.educational.textbook.bean.TextBookOrderLog;
import com.goisan.educational.textbook.dao.TextBookLogDao;
import com.goisan.educational.textbook.service.TextBookLogService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TextBookLogServiceImpl implements TextBookLogService {
    @Resource
    private TextBookLogDao textBookLogDao;

    public List<TextBookLog> textBookInventoryLog(TextBookLog textBookLog) {
        return textBookLogDao.textBookInventoryLog(textBookLog);
    }

    @Override
    public void insertTextBookLog(TextBookLog textBookLog) {
        textBookLogDao.insertTextBookLog(textBookLog);
    }

    @Override
    public void updateTextBookNum(TextBookLog textBookLog) {
        textBookLogDao.updateTextBookNum(textBookLog);
    }

    @Override
    public List<TextBook> getTextBookInventory(TextBook textBook){ return textBookLogDao.getTextBookInventory(textBook); }

    @Override
    public List<TextBook> getTextBookByIds(@Param("ids") String ids){ return textBookLogDao.getTextBookByIds(ids); }

    @Override
    public String getTotalByTermTextBookId(TextBookOrderLog textBookLog){ return textBookLogDao.getTotalByTermTextBookId(textBookLog); }

    @Override
    public String getSumTextBookOrderLogGiveNum(TextBookDeclare textBookDeclare){ return textBookLogDao.getSumTextBookOrderLogGiveNum(textBookDeclare); }
}
