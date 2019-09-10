package com.goisan.studentwork.onlineregister.service;

import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface OnlineRegisterService {

    List<OnlineRegister> getOnlineRegisterList(OnlineRegister onlineRegister);

    void saveOnlineRegister(OnlineRegister onlineRegister, MultipartFile img, MultipartFile idcardImg, MultipartFile examinationImg, MultipartFile scoreImg, MultipartFile[] hukouImg, MultipartFile[] graduatedImg);

    OnlineRegister getOnlineRegisterById(String id);

    void updateOnlineRegister(OnlineRegister onlineRegister);

    void delOnlineRegister(String id);

    //根据身份证号查询
    List<OnlineRegister> getRegisterByIDCard(OnlineRegister onlineRegister);

    // 获得报名年份
    List<String> getAllYear();

    //导出查询
    List<OnlineRegister> exportOnlineRegisterList(OnlineRegister onlineRegister);

    //报名审核
    void audit(String ids, String flag, String mind);
}