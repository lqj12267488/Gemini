package com.goisan.system.service.impl;

import com.goisan.system.bean.Parameter;
import com.goisan.system.dao.ParameterDao;
import com.goisan.system.service.ParameterService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ParameterServiceImpl implements ParameterService{
    @Resource
    private ParameterDao parameterDao;
    public List<Parameter> parameterInfo(Parameter parameter) {
        return parameterDao.parameterInfo(parameter);
    }

    public void insertParameter(Parameter parameter) {
        parameterDao.insertParameter(parameter);
    }

    public Parameter getParameterID(String id) {
        return parameterDao.getParameterID(id);
    }

    public void updateParameter(Parameter parameter) {
        parameterDao.updateParameter(parameter);
    }

    public void deleteParameter(String id) {
        parameterDao.deleteParameter(id);
    }

    public List<Parameter> checkName(Parameter parameter) {
        return parameterDao.checkName(parameter);
    }

    public List<Parameter> checkCode(Parameter parameter) {
        return parameterDao.checkCode(parameter);
    }

    public List<Parameter> checkType(Parameter parameter) {
        return parameterDao.checkType(parameter);
    }

    public List<Parameter> checkValue(Parameter parameter) {
        return parameterDao.checkValue(parameter);
    }

    @Override
    public void updateSemester(Parameter parameter) {
        parameterDao.updateSemester(parameter);
    }

    @Override
    public void updateSyear(Parameter parameter) {
        parameterDao.updateSyear(parameter);
    }

    @Override
    public String getParameterValue() {
        return parameterDao.getParameterValue();
    }
    @Override
    public String getParameterYearValue() {
        return parameterDao.getParameterYearValue();
    }

    /**
     *  id：-1
     *  type:校验开关1是0否
     *  mac:服务器mac地址
     *  create_time:有效期
     *  change_time 最后登录时间
     * @return
     * @throws Exception
     */
    @Override
    public Boolean checkMac() throws Exception{
        boolean flag = false;
        if ("1".equals(parameterDao.getMacType())){
            Map map = parameterDao.getMac();
            if (map!=null && !map.isEmpty()){
                List<String> list = CommonUtil.getMacList();
                if (list.indexOf(map.get("VALUE")) >  -1){
                    flag = true;
                    parameterDao.updateLastTime();
                }
            }
        }else {
            flag = true;
        }
        return flag;
    }
}
