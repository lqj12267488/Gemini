package com.goisan.educational.textbook.service;

import com.goisan.educational.textbook.bean.TextBook;
import com.goisan.educational.textbook.bean.TextBookDeclare;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.educational.textbook.bean.TextBookOrderLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TextBookLogService {

    List<TextBookLog> textBookInventoryLog(TextBookLog textBookLog);

    void insertTextBookLog(TextBookLog textBookLog);

    void updateTextBookNum(TextBookLog textBookLog);

    List<TextBook> getTextBookInventory(TextBook textBook);

    List<TextBook> getTextBookByIds(@Param("ids") String ids);

    String getTotalByTermTextBookId(TextBookOrderLog textBookOrderLog);

    String getSumTextBookOrderLogGiveNum(TextBookDeclare textBookDeclare);
}
