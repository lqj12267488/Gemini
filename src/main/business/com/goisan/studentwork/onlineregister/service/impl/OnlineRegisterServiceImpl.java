package com.goisan.studentwork.onlineregister.service.impl;

import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.studentwork.onlineregister.dao.OnlineRegisterDao;
import com.goisan.studentwork.onlineregister.service.OnlineRegisterService;
import com.goisan.system.bean.PathBean;
import com.goisan.system.tools.CommonUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class OnlineRegisterServiceImpl implements OnlineRegisterService {

    @Resource
    private OnlineRegisterDao onlineRegisterDao;

    @Override
    public List<OnlineRegister> getOnlineRegisterList(OnlineRegister onlineRegister) {
        return onlineRegisterDao.getOnlineRegisterList(onlineRegister);
    }

    @Override
    public void saveOnlineRegister(OnlineRegister onlineRegister, MultipartFile img, MultipartFile idcardImg, MultipartFile examinationImg, MultipartFile scoreImg, MultipartFile[] hukouImg, MultipartFile[] graduatedImg) {
        String uuid = CommonUtil.getUUID();
        String path = PathBean.BASEPATH + File.separator + "upload" + File.separator + uuid;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String tiem = sdf.format(new Date());
        try {
            File f = new File(path);
            if(!f.exists()) f.mkdirs();
            String fileName;
            //头像
            if (img != null && img.getSize() > 0){
                fileName = img.getOriginalFilename();
                onlineRegister.setImg(tiem + "_img." + CommonUtil.getFileExt(fileName));
                img.transferTo(new File(path + File.separator  + onlineRegister.getImg()));
            }
            //身份证
            if (idcardImg != null && idcardImg.getSize() > 0){
                fileName = idcardImg.getOriginalFilename();
                onlineRegister.setIdcardImg(tiem + "_idcardImg." + CommonUtil.getFileExt(fileName));
                idcardImg.transferTo(new File(path + File.separator  + onlineRegister.getIdcardImg()));
            }
            //准考证
            if (examinationImg != null && examinationImg.getSize() > 0){
                fileName = examinationImg.getOriginalFilename();
                onlineRegister.setExaminationImg(tiem + "_examinationImg." + CommonUtil.getFileExt(fileName));
                examinationImg.transferTo(new File(path + File.separator  + onlineRegister.getExaminationImg()));
            }
            //成绩单
            if (scoreImg != null && scoreImg.getSize() > 0){
                fileName = scoreImg.getOriginalFilename();
                onlineRegister.setScoreImg(tiem + "_scoreImg." + CommonUtil.getFileExt(fileName));
                scoreImg.transferTo(new File(path + File.separator  + onlineRegister.getScoreImg()));
            }
            String fileNames = "";
            //户口
            if (hukouImg != null && hukouImg.length > 0){
                new File(path + File.separator + tiem + "_hukouImg").mkdir();
                for(MultipartFile mf:hukouImg){
                    fileName = CommonUtil.getUUID() + "." + CommonUtil.getFileExt(mf.getOriginalFilename());
                    fileNames += "," + tiem + "_hukouImg" + File.separator + fileName;
                    mf.transferTo(new File(path + File.separator + tiem + "_hukouImg" + File.separator + fileName));
                }
                onlineRegister.setHukouImg(fileNames.substring(1));
            }
            //毕业证
            if (graduatedImg != null && graduatedImg.length > 0){
                fileNames = "";
                new File(path + File.separator + tiem + "_graduatedImg").mkdir();
                for(MultipartFile mf:graduatedImg){
                    fileName = CommonUtil.getUUID() + "." + CommonUtil.getFileExt(mf.getOriginalFilename());
                    fileNames += "," + tiem + "_graduatedImg" + fileName;
                    mf.transferTo(new File(path + File.separator + tiem + "_graduatedImg" + File.separator + fileName));
                }
                onlineRegister.setGraduatedImg(fileNames.substring(1));
            }
            Calendar calendar = Calendar.getInstance();
            onlineRegister.setYear(calendar.get(Calendar.YEAR));
            onlineRegister.setId(uuid);
            onlineRegisterDao.saveOnlineRegister(onlineRegister);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public OnlineRegister getOnlineRegisterById(String id) {
        return onlineRegisterDao.getOnlineRegisterById(id);
    }

    @Override
    public void updateOnlineRegister(OnlineRegister onlineRegister) {
        onlineRegisterDao.updateOnlineRegister(onlineRegister);
    }

    @Override
    public void delOnlineRegister(String id) {
        onlineRegisterDao.delOnlineRegister(id);
    }

    @Override
    public List<OnlineRegister> getRegisterByIDCard(OnlineRegister onlineRegister) {
        return onlineRegisterDao.getRegisterByIDCard(onlineRegister);
    }

    @Override
    public List<String> getAllYear() {
        return onlineRegisterDao.getAllYear();
    }

    @Override
    public List<OnlineRegister> exportOnlineRegisterList(OnlineRegister onlineRegister) {
        return onlineRegisterDao.exportOnlineRegisterList(onlineRegister);
    }

    @Transactional
    @Override
    public void audit(String ids, String flag, String mind) {
        ids = ids.replaceAll(",", "','");
        onlineRegisterDao.audit(ids, flag, mind);
        if ("1".equals(flag)){
            onlineRegisterDao.dataCopy(ids, CommonUtil.getPersonId(), CommonUtil.getDefaultDept());
        }
    }
}
