package com.goisan.educational.otherexamination.service.impl;

import com.goisan.educational.otherexamination.bean.OtherExamination;
import com.goisan.educational.otherexamination.dao.OtherExaminationDao;
import com.goisan.educational.otherexamination.service.OtherExaminationService;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.system.bean.Select2;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.ibatis.mapping.ParameterMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class OtherExaminationServiceImpl implements OtherExaminationService {
    @Autowired
    OtherExaminationDao otherExaminationDao;

    @Override
    public List getOtherExaminationList(OtherExamination otherExamination) {
        return otherExaminationDao.getOtherExaminationList(otherExamination);
    }

    @Override
    public List getScoreImport(OtherExamination otherExamination) {
        return otherExaminationDao.getScoreImport(otherExamination);
    }

    @Override
    public OtherExamination getOtherExaminationById(String id) {
        return otherExaminationDao.getOtherExaminationById(id);
    }

    @Override
    public OtherExamination getScoreImportById(String id) {
        return otherExaminationDao.getScoreImportById(id);
    }

    @Override
    public void deleteOtherExamination(String id) {
        otherExaminationDao.deleteOtherExamination(id);
    }

    @Override
    public void deleteById(String id) {
        otherExaminationDao.deleteById(id);
    }

    public Message saveScoreCon(HttpServletRequest request) {

        try {

            Map map = request.getParameterMap();
            Set<String> set  = map.keySet();
            return this.saveScore1(request.getParameterMap().keySet(), request);


        } catch (Exception e) {

            e.printStackTrace();
        }

        return new Message(0, "操作失败，请稍后重试！", null);
    }

    private Message saveScore1(Set<String> set, HttpServletRequest request) {

        try {

            if (set != null && set.size() > 0) {

                List<String> notInId = new ArrayList<>();

                for (String name : set) {

                    if (name != null && !"".equals(name) && !"type".equals(name)) {

                        String[] arrStr = name.split("_");

                        if (arrStr.length == 2) {

                            String id = arrStr[1];

                            if (id != null && !"".equals(id) && !notInId.contains(id)) {

                                notInId.add(id);

                                OtherExamination otherExamination = otherExaminationDao.getScoreImportById(id);

                                if (otherExamination != null) {

                                    if ("1".equals(otherExamination.getOpenFlag())) {

                                        continue;
                                    }

                                    String score = "0";

                                    score = request.getParameter("score_" + id);


                                    otherExamination.setScore(score);

                                    otherExaminationDao.updateOtherExaminationImport(otherExamination);
                                }
                            }
                        }
                    }
                }

                return new Message(1, "保存成功！", null);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new Message(0, "操作失败，请稍后重试！", null);
    }

    public Message openScore(String id) {

        try {

            if (id != null && !"".equals(id)) {

                otherExaminationDao.updateOpenFlag("1", CommonUtil.getPersonId(), id);
                return new Message(1, "发布成功", "success");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new Message(0, "操作失败，请稍后重试", "error");
    }

    @Override
    public void updateOtherExamination(OtherExamination otherExamination) {
        otherExaminationDao.updateOtherExamination(otherExamination);
    }

    @Override
    public void saveOtherExamination(OtherExamination otherExamination) {
        otherExaminationDao.saveOtherExamination(otherExamination);
    }

    @Override
    public void updateOtherExaminationImport(OtherExamination otherExamination) {
        otherExaminationDao.updateOtherExaminationImport(otherExamination);
    }

    @Override
    public void insertScoreImportByOtherExamination(ScoreImport scoreImport){ otherExaminationDao.insertScoreImportByOtherExamination(scoreImport); }

    @Override
    public List<ScoreImport> getScoreExamListByOtherExam(ScoreImport scoreImport){
        return otherExaminationDao.getScoreExamListByOtherExam(scoreImport);
    }
}
