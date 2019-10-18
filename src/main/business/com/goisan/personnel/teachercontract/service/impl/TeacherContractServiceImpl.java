package com.goisan.personnel.teachercontract.service.impl;

import com.goisan.personnel.teachercontract.bean.TeacherContract;
import com.goisan.personnel.teachercontract.dao.TeacherContractDao;
import com.goisan.personnel.teachercontract.service.TeacherContractService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class TeacherContractServiceImpl implements TeacherContractService {

    @Resource
    private TeacherContractDao teacherContractDao;

    @Override
    public List<TeacherContract> getTeacherContractList(TeacherContract teacherContract ) {
        List<TeacherContract> list = teacherContractDao.getTeacherContractList(teacherContract);
        for (TeacherContract bb:list) {
            getMaxContact(bb);
        }
        if (teacherContract.getContractType()!= null && !"".equals(teacherContract.getContractType()))
        {
            ArrayList<TeacherContract> copyList = new ArrayList<>(Arrays.asList(new TeacherContract[list.size()]));
            Collections.copy(copyList,list);
            for (TeacherContract tc:copyList) {
                 if (!teacherContract.getContractType().equals(tc.getContractType())){
                     list.remove(tc);
                 }
            }
        }

        if ("1".equals(teacherContract.getFature())){
            ArrayList<TeacherContract> copyList = new ArrayList<>(Arrays.asList(new TeacherContract[list.size()]));
            Collections.copy(copyList,list);
            for (TeacherContract tc:copyList) {
                if (null==tc.getContractType()){
                    list.remove(tc);
                }else if ("1".equals(tc.getContractType())||"3".equals(tc.getContractType())) {
                    if (differentDay(tc.getEndTime()) > 15){
                        list.remove(tc);
                    }
                }else{
                    if (differentDay(tc.getEndTime()) > 30){
                        list.remove(tc);
                    }
                }
            }
        }
        return list;
    }

    @Override
    public void saveTeacherContract(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        teacherContractDao.saveTeacherContract(baseBean);
    }

    @Override
    public BaseBean getTeacherContractByPersonId(String personId, String deptId) {
        return teacherContractDao.getTeacherContractByPersonId(personId,deptId);
    }

    /**
     * 根据personId查询是否存在
     * 存在,根据personId修改;
     * 不存在 新增
     * @param teacherContract
     */
    @Override
    public void updateTeacherContract(TeacherContract teacherContract) {
        String personId = teacherContract.getPersonId();
        BaseBean baseBean = teacherContractDao.getTeachConByPersonId(personId);
        if (baseBean == null){
            CommonUtil.save(teacherContract);
            teacherContractDao.saveTeacherContract(teacherContract);
        }else {
            CommonUtil.update(teacherContract);
            teacherContractDao.updateTeacherContract(teacherContract);
        }
    }

    @Override
    public TeacherContract getMaxTeachConByPersonId(String personId) {
        TeacherContract teachCon = (TeacherContract) teacherContractDao.getTeachConByPersonId(personId);
        return  getMaxContact(teachCon);
    }

    /**
     * 获取最大合同
     *
     * @param contract
     * @return
     */
    public TeacherContract getMaxContact(TeacherContract contract){
        if (null!=contract) {
            String syStartTime = contract.getSyStartTime();
            String firstStartTime = contract.getFirstStartTime();
            String secStartTime = contract.getSecStartTime();
            String thirdStartTime = contract.getThirdStartTime();
            String jzStartTime = contract.getJzStartTime();
            ArrayList<Long> longs = toListLong(syStartTime, firstStartTime, secStartTime, thirdStartTime, jzStartTime);
            Collections.sort(longs);
            if (longs.size() > 0) {
                /**设置相关信息*/
                Long st = longs.get(longs.size() - 1);
                Date date = new Date(st);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String startTime = sdf.format(date);
                contract.setStartTime(startTime);
                setMaxContact(contract, startTime);
            }
        }
        return contract;
    }

    public ArrayList<Long> toListLong(String syStartTime,String firstStartTime,String secStartTime,String thirdStartTime, String jzStartTime){
        ArrayList<Long> longs = new ArrayList<>();
        if (null != syStartTime) {
            longs.add(toLong(syStartTime));
        }
        if (null != firstStartTime) {
            longs.add(toLong(firstStartTime));
        }
        if (null != secStartTime) {
            longs.add(toLong(secStartTime));
        }
        if (null != thirdStartTime) {
            longs.add(toLong(thirdStartTime));
        }
        if (null != jzStartTime) {
            longs.add(toLong(jzStartTime));
        }
        return longs;
    }

    public Long toLong(String startTime){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (startTime!=null){
            try {
                Date parse = sdf.parse(startTime);
                return  parse.getTime();
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public TeacherContract setMaxContact(TeacherContract teacherContract,String startTime){
        if (startTime.equals(teacherContract.getSyStartTime())){
            teacherContract.setEndTime(teacherContract.getSyEndTime());
            teacherContract.setContractType("1");
            teacherContract.setContractTypeShow("试用期");
        }else if (startTime.equals(teacherContract.getFirstStartTime())){
            teacherContract.setEndTime(teacherContract.getFirstEndTime());
            teacherContract.setContractType("2");
            teacherContract.setContractTypeShow("劳动合同");
        }else if (startTime.equals(teacherContract.getSecStartTime())){
            teacherContract.setEndTime(teacherContract.getSecEndTime());
            teacherContract.setContractType("2");
            teacherContract.setContractTypeShow("劳动合同");
        }else if (startTime.equals(teacherContract.getThirdStartTime())){
            teacherContract.setEndTime(teacherContract.getThirdEndTime());
            teacherContract.setContractType("2");
            teacherContract.setContractTypeShow("劳动合同");
        }else{
            teacherContract.setEndTime(teacherContract.getJzEndTime());
            teacherContract.setContractType("3");
            teacherContract.setContractTypeShow("兼职协议");
        }
        return teacherContract;
    }

    public long differentDay(String endTime){
        Date now = new Date();
        Date st = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            st = sdf.parse(endTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        long difDay = (st.getTime()-now.getTime())/(60*60*24*1000);
        return difDay;
    }

}
